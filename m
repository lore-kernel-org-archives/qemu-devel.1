Received: from eggs.gnu.org ([2001:4830:134:3::10]:36217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1coWfL-0001Pu-BL
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 10:46:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1coWfG-0003ct-Bf
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 10:46:11 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:35263)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1coWfG-0003cm-5D
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 10:46:06 -0400
Received: by mail-qt0-x244.google.com with SMTP id r5so5995582qtb.2
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 07:46:05 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170130131517.8092-1-sw@weilnetz.de>
	<c16d6c6a-96b8-01fd-ca20-978e9c1a2367@redhat.com>
	<d09ccce8-9ac4-66f5-36e1-132c9cffd9f7@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4e1a0f31-c9a8-f504-11a0-191158390e3d@amsat.org>
Date: Thu, 16 Mar 2017 11:46:00 -0300
MIME-Version: 1.0
In-Reply-To: <d09ccce8-9ac4-66f5-36e1-132c9cffd9f7@redhat.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] target/s390x: Fix broken user mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Stefan Weil <sw@weilnetz.de>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org, Bruce Rogers <brogers@suse.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>

Hi Stefan, Richard.

On 03/16/2017 10:28 AM, David Hildenbrand wrote:
> On 02.03.2017 20:56, David Hildenbrand wrote:
>> Am 30.01.2017 um 14:15 schrieb Stefan Weil:
>>> Returning NULL from get_max_cpu_model results in a SIGSEGV runtime error.
>>>
>>> Signed-off-by: Stefan Weil <sw@weilnetz.de>
>>> ---
>>>
>>> v2: Re-sent as v1 was damaged by my mailer.
>>>
>>> This is also broken in Debian.
>>>
>>> In addition, there is no default CPU ("any"), so binfmt and related
>>> actions currently don't work. I hacked my local installation by
>>> duplicating the "qemu" cpu definition for "any", but maybe there is
>>> a better solution.
>>
>> That should then already work.
>>
>>>
>>> Regards
>>> Stefan
>>>
>>>  target/s390x/cpu_models.c | 2 --
>>>  1 file changed, 2 deletions(-)
>>>
>>> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
>>> index 2a894ee..6e34763 100644
>>> --- a/target/s390x/cpu_models.c
>>> +++ b/target/s390x/cpu_models.c
>>> @@ -660,7 +660,6 @@ static void check_compatibility(const S390CPUModel *max_model,
>>>
>>>  static S390CPUModel *get_max_cpu_model(Error **errp)
>>>  {
>>> -#ifndef CONFIG_USER_ONLY
>>>      static S390CPUModel max_model;
>>>      static bool cached;
>>>
>>> @@ -680,7 +679,6 @@ static S390CPUModel *get_max_cpu_model(Error **errp)
>>>          cached = true;
>>>          return &max_model;
>>>      }
>>> -#endif
>>>      return NULL;
>>>  }
>>>
>>>
>>
>> I thought this was already picked up for stable...
>> But looks like only the "any" model fixup got.
>>
>> So
>>
>> Acked-by: David Hildenbrand <david@redhat.com>
>>
>
> Ping, can somebody please pick this up?

I see at least two possible changes:

the nasty one to catch bug:

@@ -681,7 +681,7 @@ static S390CPUModel *get_max_cpu_model(Error **errp)
          return &max_model;
      }
  #endif
-    return NULL;
+    abort();
  }

and the nicer one to avoid SIGSEGV:

@@ -734,8 +734,10 @@ void s390_realize_cpu_model(CPUState *cs, Error **errp)
      }

      max_model = get_max_cpu_model(errp);
-    if (*errp) {
-        error_prepend(errp, "CPU models are not available: ");
+    if (max_model == NULL) {
+        if (*errp) {
+            error_prepend(errp, "CPU models are not available: ");
+        } else {
+            error_setg(errp, "CPU models are not available");
+        }
          return;
      }

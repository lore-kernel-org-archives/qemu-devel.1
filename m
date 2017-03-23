Received: from eggs.gnu.org ([2001:4830:134:3::10]:45791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cr7oT-0007AR-V7
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 14:50:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cr7oT-0004nL-6V
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 14:50:21 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:35148)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cr7oT-0004n8-0h
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 14:50:21 -0400
Received: by mail-wm0-x22f.google.com with SMTP id u132so69250612wmg.0
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 11:50:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87wpbgc673.fsf@dusky.pond.sub.org>
References: <20170323160315.19696-1-eblake@redhat.com>
	<87wpbgc673.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Mar 2017 18:49:59 +0000
Message-ID: <CAFEAcA8fp3rpYK8SzL8RXKnBJVt4+aSeRj+Gu2QQ74rcgR4ObQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH for-2.9] qom: Fix regression with 'qom-type'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>, "Richard W.M. Jones" <rjones@redhat.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>

On 23 March 2017 at 16:24, Markus Armbruster <armbru@redhat.com> wrote:
> Eric Blake <eblake@redhat.com> writes:
>
>> Commit 9a6d1ac assumed that 'qom-type' could be removed from QemuOpts
>> with no ill effects.  However, this command line proves otherwise:
>>
>> $ ./x86_64-softmmu/qemu-system-x86_64 -nodefaults -nographic -qmp stdio \
>>   -object rng-random,filename=/dev/urandom,id=rng0 \
>>   -device virtio-rng-pci,rng=rng0
>> qemu-system-x86_64: -object rng-random,filename=/dev/urandom,id=rng0: Parameter 'qom-type' is missing
>
> Shows that our test coverage is still inadequate.  Also shows that I
> should do more manual testing myself.  Sorry for the inconvenience!
>
>> Fix the regression by restoring qom-type in opts after its temporary
>> removal that was needed for the duration of user_creatable_add_opts().
>>
>> Reported-by: Richard W. M. Jones <rjones@redhat.com>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>  qom/object_interfaces.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
>> index 9c271ad..d4253a8 100644
>> --- a/qom/object_interfaces.c
>> +++ b/qom/object_interfaces.c
>> @@ -122,6 +122,7 @@ Object *user_creatable_add_opts(QemuOpts *opts, Error **errp)
>>      }
>>      if (!id) {
>>          error_setg(errp, QERR_MISSING_PARAMETER, "id");
>> +        qemu_opt_set(opts, "qom-type", type, &error_abort);
>>          g_free(type);
>>          return NULL;
>>      }
>> @@ -134,6 +135,7 @@ Object *user_creatable_add_opts(QemuOpts *opts, Error **errp)
>>      visit_free(v);
>>
>>      qemu_opts_set_id(opts, (char *) id);
>> +    qemu_opt_set(opts, "qom-type", type, &error_abort);
>>      g_free(type);
>>      QDECREF(pdict);
>>      return obj;
>
> The awkwardness increases a bit more, but I don't have better ideas.
>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>
> Peter, can you apply this as a build fix?

Sure; applied to master.

-- PMM

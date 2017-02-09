Received: from eggs.gnu.org ([2001:4830:134:3::10]:57333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cbsEO-0007Cc-8C
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 12:10:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cbsEJ-0002iJ-8Q
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 12:10:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cbsEJ-0002hi-1g
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 12:09:59 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8F6EA9F73F
	for <qemu-devel@nongnu.org>; Thu,  9 Feb 2017 17:09:58 +0000 (UTC)
References: <20170202145141.17138-1-marcandre.lureau@redhat.com>
	<20170202145141.17138-6-marcandre.lureau@redhat.com>
	<36848fad-c7b9-21e3-0c6e-78014e9580c4@redhat.com>
	<2003631234.1298629.1486497719887.JavaMail.zimbra@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f4682701-67b0-2231-f4ff-d33b121e8823@redhat.com>
Date: Thu, 9 Feb 2017 18:09:56 +0100
MIME-Version: 1.0
In-Reply-To: <2003631234.1298629.1486497719887.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 05/22] main: free root container
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <mlureau@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, eblake@redhat.com



On 07/02/2017 21:01, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> ----- Original Message -----
>>
>>
>> On 02/02/2017 15:51, Marc-Andr=C3=A9 Lureau wrote:
>>> This should eventually free all objects that are only referenced by
>>> their parents.
>>>
>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>  vl.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/vl.c b/vl.c
>>> index 0b72b12878..945df1d17f 100644
>>> --- a/vl.c
>>> +++ b/vl.c
>>> @@ -4640,6 +4640,7 @@ int main(int argc, char **argv, char **envp)
>>>      audio_cleanup();
>>>      monitor_cleanup();
>>>      qemu_chr_cleanup();
>>> +    object_unref(object_get_root());
>>
>> This seems dangerous.  I'm pretty sure that a lot of non-hot-unpluggab=
le
>> devices would leak or crash.
>=20
> make check is ok. Any suggestion what else to check?

Not sure...  I would have to try with some logging to see what this
does.  But it doesn't seem safe, most devices are really not meant to be
hot-removed.

> This patch was added so that /chardevs container is cleaned up (with
> the following patches). Perhaps I could be more conservative and only
> unref (oops unparent) /chardevs.

Yeah, that would work.

Paolo

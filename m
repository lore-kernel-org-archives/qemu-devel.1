Received: from eggs.gnu.org ([2001:4830:134:3::10]:33601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eQv4v-0004SI-Lg
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:03:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eQv4h-0000l8-EJ
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:03:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60980)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eQv4h-0000ja-8T
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:03:19 -0500
References: <20171215181810.4122-1-marcandre.lureau@redhat.com>
	<abddfb99-c6ca-70ba-eae9-16f57f60b41d@redhat.com>
	<CAJ+F1C+3u+yy+LHxkv8DjxMTeCi7oon8s01g2YYMoRB4sNuv1A@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c6cec568-01c3-120d-16f8-49addb0f230b@redhat.com>
Date: Mon, 18 Dec 2017 14:02:35 +0100
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+3u+yy+LHxkv8DjxMTeCi7oon8s01g2YYMoRB4sNuv1A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] checkpatch: warn when using volatile with
 a comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Laszlo Ersek <lersek@redhat.com>, Fam Zheng <famz@redhat.com>

On 18/12/2017 13:54, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Mon, Dec 18, 2017 at 1:49 PM, Paolo Bonzini <pbonzini@redhat.com> wr=
ote:
>> On 15/12/2017 19:18, Marc-Andr=C3=A9 Lureau wrote:
>>> Instead of an error, lower to a warning message, assuming the comment
>>> gives some justification.
>>>
>>> Discussed in:
>>> '[Qemu-devel] [PATCH] dump-guest-memory.py: fix "You can't do that wi=
thout a process to debug"'
>>>
>>> Suggested-by: Fam Zheng <famz@redhat.com>
>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>
>> We can drop the error at all if there is a comment.  Also, "volatile s=
ig_atomic_t" is probably self-explanatory and usually correct.  So what a=
bout this:
>>
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> index f5a523af10..3dc27d9656 100755
>> --- a/scripts/checkpatch.pl
>> +++ b/scripts/checkpatch.pl
>> @@ -2475,13 +2475,11 @@ sub process {
>>
>>  # no volatiles please
>>                 my $asm_volatile =3D qr{\b(__asm__|asm)\s+(__volatile_=
_|volatile)\b};
>> -               if ($line =3D~ /\bvolatile\b/ && $line !~ /$asm_volati=
le/) {
>> -                       my $msg =3D "Use of volatile is usually wrong:=
 see Documentation/volatile-considered-harmful.txt\n" . $herecurr;
>> -                       if (ctx_has_comment($first_line, $linenr)) {
>> -                               WARN($msg);
>> -                       } else {
>> -                               ERROR($msg);
>> -                       }
>> +               if ($line =3D~ /\bvolatile\b/ && $line !~ /$asm_volati=
le/ &&
>> +                    $line !~ /sig_atomic_t/ &&
>> +                    !ctx_has_comment($first_line, $linenr)) {
>> +                       my $msg =3D "Use of volatile is usually wrong,=
 please add a comment\n" . $herecurr;
>> +                        ERROR($msg);
>>                 }
>>
>=20
> Fine for me, can you send a proper patch?

Yes, will do.

Paolo

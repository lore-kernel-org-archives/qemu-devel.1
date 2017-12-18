Received: from eggs.gnu.org ([2001:4830:134:3::10]:52330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <darren.kenny@oracle.com>) id 1eQvbM-0004a8-NG
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:37:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <darren.kenny@oracle.com>) id 1eQvbI-0002Qv-Ao
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:37:04 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:33275)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <darren.kenny@oracle.com>)
	id 1eQvbI-0002Nx-25
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:37:00 -0500
Date: Mon, 18 Dec 2017 13:36:52 +0000
From: Darren Kenny <darren.kenny@oracle.com>
Message-ID: <20171218133652.wq74ymqhmrxvfoka@starbug-vm.ie.oracle.com>
References: <20171215181810.4122-1-marcandre.lureau@redhat.com>
	<abddfb99-c6ca-70ba-eae9-16f57f60b41d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <abddfb99-c6ca-70ba-eae9-16f57f60b41d@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, lersek@redhat.com, famz@redhat.com

Hi Paolo,

Slight nit on the subject line, did you mean to s/with/without/ -
that seems to reflect the change in the patch more correctly.

Thanks,

Darren.

On Mon, Dec 18, 2017 at 01:49:52PM +0100, Paolo Bonzini wrote:
>On 15/12/2017 19:18, Marc-Andr=C3=A9 Lureau wrote:
>> Instead of an error, lower to a warning message, assuming the comment
>> gives some justification.
>>
>> Discussed in:
>> '[Qemu-devel] [PATCH] dump-guest-memory.py: fix "You can't do that wit=
hout a process to debug"'
>>
>> Suggested-by: Fam Zheng <famz@redhat.com>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
>We can drop the error at all if there is a comment.  Also, "volatile sig=
_atomic_t" is probably self-explanatory and usually correct.  So what abo=
ut this:
>
>diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>index f5a523af10..3dc27d9656 100755
>--- a/scripts/checkpatch.pl
>+++ b/scripts/checkpatch.pl
>@@ -2475,13 +2475,11 @@ sub process {
>
> # no volatiles please
> 		my $asm_volatile =3D qr{\b(__asm__|asm)\s+(__volatile__|volatile)\b};
>-		if ($line =3D~ /\bvolatile\b/ && $line !~ /$asm_volatile/) {
>-			my $msg =3D "Use of volatile is usually wrong: see Documentation/vol=
atile-considered-harmful.txt\n" . $herecurr;
>-			if (ctx_has_comment($first_line, $linenr)) {
>-				WARN($msg);
>-			} else {
>-				ERROR($msg);
>-			}
>+		if ($line =3D~ /\bvolatile\b/ && $line !~ /$asm_volatile/ &&
>+                    $line !~ /sig_atomic_t/ &&
>+                    !ctx_has_comment($first_line, $linenr)) {
>+			my $msg =3D "Use of volatile is usually wrong, please add a comment\=
n" . $herecurr;
>+                        ERROR($msg);
> 		}
>
> # warn about #if 0
>

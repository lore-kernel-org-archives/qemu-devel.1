Received: from eggs.gnu.org ([2001:4830:134:3::10]:53856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <darren.kenny@oracle.com>) id 1eQvcc-0005Th-Py
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:38:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <darren.kenny@oracle.com>) id 1eQvcY-0003YI-Lh
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:38:22 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:47199)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <darren.kenny@oracle.com>)
	id 1eQvcY-0003Xb-Eo
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:38:18 -0500
Date: Mon, 18 Dec 2017 13:38:13 +0000
From: Darren Kenny <darren.kenny@oracle.com>
Message-ID: <20171218133813.ittl5hfvzdx3d3r6@starbug-vm.ie.oracle.com>
References: <20171215181810.4122-1-marcandre.lureau@redhat.com>
	<abddfb99-c6ca-70ba-eae9-16f57f60b41d@redhat.com>
	<20171218133652.wq74ymqhmrxvfoka@starbug-vm.ie.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20171218133652.wq74ymqhmrxvfoka@starbug-vm.ie.oracle.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, lersek@redhat.com, famz@redhat.com

Nevermind, saw that updated comment in the later patch...

Thanks,

Darren.

On Mon, Dec 18, 2017 at 01:36:52PM +0000, Darren Kenny wrote:
>Hi Paolo,
>
>Slight nit on the subject line, did you mean to s/with/without/ -
>that seems to reflect the change in the patch more correctly.
>
>Thanks,
>
>Darren.
>
>On Mon, Dec 18, 2017 at 01:49:52PM +0100, Paolo Bonzini wrote:
>>On 15/12/2017 19:18, Marc-Andr=C3=A9 Lureau wrote:
>>>Instead of an error, lower to a warning message, assuming the comment
>>>gives some justification.
>>>
>>>Discussed in:
>>>'[Qemu-devel] [PATCH] dump-guest-memory.py: fix "You can't do that wit=
hout a process to debug"'
>>>
>>>Suggested-by: Fam Zheng <famz@redhat.com>
>>>Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>
>>We can drop the error at all if there is a comment.  Also, "volatile si=
g_atomic_t" is probably self-explanatory and usually correct.  So what ab=
out this:
>>
>>diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>>index f5a523af10..3dc27d9656 100755
>>--- a/scripts/checkpatch.pl
>>+++ b/scripts/checkpatch.pl
>>@@ -2475,13 +2475,11 @@ sub process {
>>
>># no volatiles please
>>		my $asm_volatile =3D qr{\b(__asm__|asm)\s+(__volatile__|volatile)\b};
>>-		if ($line =3D~ /\bvolatile\b/ && $line !~ /$asm_volatile/) {
>>-			my $msg =3D "Use of volatile is usually wrong: see Documentation/vo=
latile-considered-harmful.txt\n" . $herecurr;
>>-			if (ctx_has_comment($first_line, $linenr)) {
>>-				WARN($msg);
>>-			} else {
>>-				ERROR($msg);
>>-			}
>>+		if ($line =3D~ /\bvolatile\b/ && $line !~ /$asm_volatile/ &&
>>+                    $line !~ /sig_atomic_t/ &&
>>+                    !ctx_has_comment($first_line, $linenr)) {
>>+			my $msg =3D "Use of volatile is usually wrong, please add a comment=
\n" . $herecurr;
>>+                        ERROR($msg);
>>		}
>>
>># warn about #if 0
>>

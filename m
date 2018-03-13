Received: from eggs.gnu.org ([2001:4830:134:3::10]:60320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1evhVZ-0004z1-Tk
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 06:50:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1evhVU-0000yh-14
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 06:50:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58326 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1evhVT-0000xX-QI
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 06:50:11 -0400
References: <20180312131806.23209-1-stefanha@redhat.com>
	<43378184-a291-263f-b8b2-dedc455622e3@redhat.com>
	<20180313103736.GC16582@stefanha-x1.localdomain>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <98b9bf37-5bca-35f0-7178-dd640ee3fe81@redhat.com>
Date: Tue, 13 Mar 2018 11:49:57 +0100
MIME-Version: 1.0
In-Reply-To: <20180313103736.GC16582@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="lguqfeAOWzgoVvy1jAffyzqj57vhPw8VL"
Subject: Re: [Qemu-devel] [PATCH] checkpatch: warn about missing MAINTAINERS
 file changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lguqfeAOWzgoVvy1jAffyzqj57vhPw8VL
From: Thomas Huth <thuth@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Message-ID: <98b9bf37-5bca-35f0-7178-dd640ee3fe81@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] checkpatch: warn about missing MAINTAINERS
 file changes
References: <20180312131806.23209-1-stefanha@redhat.com>
 <43378184-a291-263f-b8b2-dedc455622e3@redhat.com>
 <20180313103736.GC16582@stefanha-x1.localdomain>
In-Reply-To: <20180313103736.GC16582@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13.03.2018 11:37, Stefan Hajnoczi wrote:
> On Mon, Mar 12, 2018 at 02:46:20PM +0100, Thomas Huth wrote:
>> On 12.03.2018 14:18, Stefan Hajnoczi wrote:
>>> Warn if files are added/renamed/deleted without MAINTAINERS file
>>> changes.  This has helped me in Linux and we could benefit from this
>>> check in QEMU.
>>>
>>> This patch is a manual cherry-pick of Linux commit
>>> 13f1937ef33950b1112049972249e6191b82e6c9 ("checkpatch: emit a warning=
 on
>>> file add/move/delete") by Joe Perches <joe@perches.com>.
>>>
>>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>>> ---
>>> Note the 80-char lines are from upstream code.  Keep them as-is.
>>>
>>>  scripts/checkpatch.pl | 19 +++++++++++++++++++
>>>  1 file changed, 19 insertions(+)
>>>
>>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>>> index d1fe79bcc4..d0d8f63d48 100755
>>> --- a/scripts/checkpatch.pl
>>> +++ b/scripts/checkpatch.pl
>>> @@ -1177,6 +1177,7 @@ sub process {
>>>  	our $clean =3D 1;
>>>  	my $signoff =3D 0;
>>>  	my $is_patch =3D 0;
>>> +	my $reported_maintainer_file =3D 0;
>>> =20
>>>  	our @report =3D ();
>>>  	our $cnt_lines =3D 0;
>>> @@ -1379,6 +1380,24 @@ sub process {
>>>  			}
>>>  		}
>>> =20
>>> +# Check if MAINTAINERS is being updated.  If so, there's probably no=
 need to
>>> +# emit the "does MAINTAINERS need updating?" message on file add/mov=
e/delete
>>> +		if ($line =3D~ /^\s*MAINTAINERS\s*\|/) {
>>> +			$reported_maintainer_file =3D 1;
>>> +		}
>>> +
>>> +# Check for added, moved or deleted files
>>> +		if (!$reported_maintainer_file &&
>>> +		    ($line =3D~ /^(?:new|deleted) file mode\s*\d+\s*$/ ||
>>> +		     $line =3D~ /^rename (?:from|to) [\w\/\.\-]+\s*$/ ||
>>> +		     ($line =3D~ /\{\s*([\w\/\.\-]*)\s*\=3D\>\s*([\w\/\.\-]*)\s*\}=
/ &&
>>> +		      (defined($1) || defined($2))))) {
>>> +			$is_patch =3D 1;
>>> +			$reported_maintainer_file =3D 1;
>>> +			WARN("added, moved or deleted file(s), does MAINTAINERS need upda=
ting?\n" .
>>> +				$herecurr);
>>
>> Could you please turn this into a notification instead of a warning? F=
or
>> rationale, please see the discussion of this patch last year:
>>
>> http://lists.gnu.org/archive/html/qemu-devel/2017-01/msg05753.html
>=20
> It's a warning, not an error, so this already means "don't treat it as
> fatal".
>=20
> Why is a warning a bad user experience but a notification would be fine=
?

Since this will likely cause a lot of false positives. I think people
will then rather be annoyed if checkpatch.pl nags them with a warning in
these cases.

 Thomas


--lguqfeAOWzgoVvy1jAffyzqj57vhPw8VL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJap6zaAAoJEC7Z13T+cC21dicQAKDwNzZlwd6f6XeClpf8xhII
DuDIu2mkpCJoSisjTX2Sb7v3J5Tg/0A4N86LQNwNW5J5zBLiwwbujzw+N4o9bBPr
ED/6tEyacTvFUBYTt+IeTjwKZr6vBPnv0FhiK8zkiZ6bWtqcZom0ppMZRupCg5z+
PClHRFHxJljqrqZQQoWHdjkDRonzXEQux3lP3cy/MFzqY4xdlczjR0PVa/e5ALle
rCxf6fdjSbCeI0XpLqbk3CisAzem6NBHqenWXOueHWSrF9jc68hszWDBsumkeK/u
KKv+m/3pxPL8c80NtJhrOGa7untLegHiRMJT8VV3/7P/NFxKwuFrM882+i58p/Rr
NKQxLoWvAKc0eDsSDsEvPXsIcFFl74087mPtSkTSglJltcpgWC5wfCw6Ws/3ai7C
QBSsGVbEwIY0XWuiPi5VP3oLQnfQjAnzgGIJO09/9h0TutiwWj0UdUFKzZK8eXMG
BOsUh40pDLk7D5iczxmXWVlqyWHrwPAGczVWeVmRjCLFG+eLiG56Y+Q51oOxGu2L
efR+p5DR0dSRT0RQ8z8gwJtZ5jB+Qc34lDi+A1zEQ17qWSJHcp7K/6DB7U36iZu4
xUibo3pfwslbAsKXCJmHuTt4ErYyGM+jG7T3+Fb56oISOjyMp3Lau6mjyYsE0Z9u
+koNaSoNy186Fob29ASf
=DJC8
-----END PGP SIGNATURE-----

--lguqfeAOWzgoVvy1jAffyzqj57vhPw8VL--

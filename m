Received: from eggs.gnu.org ([2001:4830:134:3::10]:50895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cJlJl-0001SD-KC
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 13:08:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cJlJk-0002jD-KJ
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 13:08:45 -0500
References: <20161201170624.26496-1-lersek@redhat.com>
	<148227487620.73.10055858460424473693@790289a7ca88>
	<20161221152226.GH3808@thinpad.lan.raisama.net>
	<70b42a58-381d-7011-7eef-2120af178f91@redhat.com>
	<20161221180155.GI3808@thinpad.lan.raisama.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e45bb195-578f-6afc-8617-f75e7775193e@redhat.com>
Date: Wed, 21 Dec 2016 19:08:29 +0100
MIME-Version: 1.0
In-Reply-To: <20161221180155.GI3808@thinpad.lan.raisama.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] checkpatch.pl false positive (was Re: [PATCH v4
 0/7] q35: add negotiable broadcast SMI)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, famz@redhat.com, mst@redhat.com, somlo@cmu.edu, Markus Armbruster <armbru@redhat.com>, michael@walle.cc, qemu-arm@nongnu.org, kraxel@redhat.com, zhaoshenglong@huawei.com, lersek@redhat.com, imammedo@redhat.com



On 21/12/2016 19:01, Eduardo Habkost wrote:
> The following code replaces the whole "{ .driver =3D ... }" block
> with "1":
>=20
> 	# Flatten any parentheses and braces
> 	while ($dstat =3D~ s/\([^\(\)]*\)/1/ ||
> 	       $dstat =3D~ s/\{[^\{\}]*\}/1/ ||
> 	       $dstat =3D~ s/\[[^\{\}]*\]/1/)
> 	{
> 	}

Maybe change it like

- 	       $dstat =3D~ s/\{[^\{\}]*\}/1/ ||
+ 	       $dstat =3D~ s/\{[^\{\}]*;[^\{\}]*\}/1;/ ||

so that it requires a statement?  It would have a false positive on
strings containing a semicolon, but that's not a big deal (or could be
fixed by similarly turning strings into just "").

Paolo

> The following change fixes the bug, but I don't know if it has
> unwanted side-effects:
>=20
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index f084542..0aab3ac 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2200,6 +2200,10 @@ sub process {
>                         $dstat =3D~ s/^\s*//s;
>                         $dstat =3D~ s/\s*$//s;
> =20
> +                       # remove braces that cover the whole block, if =
any:
> +                       $dstat =3D~ s/^\{//;
> +                       $dstat =3D~ s/\}$//;
> +
>                         # Flatten any parentheses and braces
>                         while ($dstat =3D~ s/\([^\(\)]*\)/1/ ||
>                                $dstat =3D~ s/\{[^\{\}]*\}/1/ ||


Paolo

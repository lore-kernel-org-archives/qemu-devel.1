Received: from eggs.gnu.org ([2001:4830:134:3::10]:50954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYWjf-0005Yw-Cx
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:13:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYWjc-0002OS-5i
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:13:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45406 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fYWjc-0002Ne-0S
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:13:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 29EC0B5C6
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 13:13:15 +0000 (UTC)
Date: Thu, 28 Jun 2018 14:13:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180628131311.GA13361@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180418171151.5263-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180418171151.5263-1-berrange@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] configure: add sanity check to catch
 builds from "git archive"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

Opps, forgot to CC Paolo on this patch for the "misc" queue.

On Wed, Apr 18, 2018 at 06:11:51PM +0100, Daniel P. Berrang=C3=A9 wrote:
> The "git archive" feature creates tarballs which are missing all
> submodule content. GitHub unhelpfully provides users with "Download"
> links that claim to give them valid source release tarballs. These
> GitHub archives will not be buildable as they are created by the
> "git archive" feature and so are missing content. The user gets
> unhelpful messages from make such as:
>=20
>   fatal error: ui/input-keymap-atset1-to-qcode.c: No such file or direc=
tory
>=20
> By adding a sanity check we can give users an informative message about
> what they've done wrong.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  configure | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/configure b/configure
> index 0a19b033bc..089b00068c 100755
> --- a/configure
> +++ b/configure
> @@ -296,6 +296,24 @@ then
>  else
>      git_update=3Dno
>      git_submodules=3D""
> +
> +    if ! test -f "$source_path/ui/keycodemapdb/README"
> +    then
> +        echo
> +        echo "ERROR: missing file $source_path/ui/keycodemapdb/README"
> +        echo
> +        echo "This is not a GIT checkout but module content appears to=
"
> +        echo "be missing. Do not use 'git archive' or GitHub download =
links"
> +        echo "to acquire QEMU source archives. Non-GIT builds are only=
"
> +        echo "supported with source archives linked from:"
> +        echo
> +        echo "  https://www.qemu.org/download/"
> +        echo
> +        echo "Developers working with GIT can use scripts/archive-sour=
ce.sh"
> +        echo "if they need to create valid source archives."
> +        echo
> +        exit 1
> +    fi
>  fi
>  git=3D"git"
> =20
> --=20
> 2.14.3
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

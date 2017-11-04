Received: from eggs.gnu.org ([2001:4830:134:3::10]:51083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eAxXE-0000bT-VR
	for qemu-devel@nongnu.org; Sat, 04 Nov 2017 08:26:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eAxXB-0001h8-Ql
	for qemu-devel@nongnu.org; Sat, 04 Nov 2017 08:26:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33114)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eAxXB-0001f6-KU
	for qemu-devel@nongnu.org; Sat, 04 Nov 2017 08:26:45 -0400
Date: Sat, 4 Nov 2017 20:26:40 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171104122640.GA11939@lemon>
References: <20171103131229.4737-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20171103131229.4737-1-famz@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] docker: Improved image checksum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Fri, 11/03 21:12, Fam Zheng wrote:
> When a base image locally defined by QEMU, such as in the debian images=
,
> is updated, the dockerfile checksum mechanism in docker.py still skips
> updating the derived image, because it only looks at the literal conten=
t
> of the dockerfile, without considering changes to the base image.
>=20
> For example we have a recent fix e58c1f9b35e81 that fixed
> debian-win64-cross by updating its base image, debian8-mxe, but due to
> above "feature" of docker.py the image in question is automatically NOT
> rebuilt unless you add NOCACHE=3D1. It is noticed on Shippable:
>=20
> https://app.shippable.com/github/qemu/qemu/runs/541/2/console
>=20
> because after the fix is merged, the error still occurs, and the log
> shows the container image is, as explained above, not updated.
>=20
> This is because at the time docker.py was written, there wasn't any
> dependencies between QEMU's docker images.
>=20
> Now improve this to preprocess any "FROM qemu:*" directives in the
> dockerfiles while doing checksum, and inline the base image's dockerfil=
e
> content, recursively. This ensures any changes on the depended _QEMU_
> images are taken into account.
>=20
> This means for external images that we expect to retrieve from docker
> registries, we still do it as before. It is not perfect, because
> registry images can get updated too. Technically we could substitute th=
e
> image name with its hex ID as obtained with $(docker images $IMAGE
> --format=3D"{{.Id}}"), but --format is not supported by RHEL 7, so leav=
e
> it for now.
>=20
> Reported-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> Signed-off-by: Fam Zheng <famz@redhat.com>

Queued, thanks.

Fam

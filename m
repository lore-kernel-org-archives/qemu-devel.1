Received: from eggs.gnu.org ([2001:4830:134:3::10]:42175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fPlw2-0008BB-BI
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:37:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fPlvz-0005d0-N6
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:37:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58724 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fPlvz-0005cp-I8
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:37:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 25051401EF17
	for <qemu-devel@nongnu.org>; Mon,  4 Jun 2018 09:37:51 +0000 (UTC)
Date: Mon, 4 Jun 2018 11:37:50 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180604093750.mtlx2frtx5mzv5w2@sirius.home.kraxel.org>
References: <20180601162749.27406-1-marcandre.lureau@redhat.com>
	<20180601162749.27406-12-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180601162749.27406-12-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 11/12] Add virtio-gpu vhost-user backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

On Fri, Jun 01, 2018 at 06:27:48PM +0200, Marc-Andr=E9 Lureau wrote:
> Add to virtio-gpu devices a "vhost-user" property. When set, the
> associated vhost-user backend is used to handle the virtio rings.
>=20
> For now, a socketpair is created for the backend to share the rendering
> results with qemu via a simple VHOST_GPU protocol.

Why this isn't a separate device, like vhost-user-input-pci?

> +typedef struct VhostGpuUpdate {
> +    uint32_t scanout_id;
> +    uint32_t x;
> +    uint32_t y;
> +    uint32_t width;
> +    uint32_t height;
> +    uint8_t data[];
> +} QEMU_PACKED VhostGpuUpdate;

Hmm, when designing a new protocol I think we can do better than just
squeering the pixels into a tcp stream.  Use shared memory instead?  Due
to vhost we are limited to linux anyway, so we might even consider stuff
like dmabufs here.

cheers,
  Gerd

Received: from eggs.gnu.org ([2001:4830:134:3::10]:54987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1eOZKr-0000Az-HB
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 20:26:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1eOZKn-0002n3-Df
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 20:26:17 -0500
Received: from mga03.intel.com ([134.134.136.65]:43032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <changpeng.liu@intel.com>)
	id 1eOZKn-0002gt-3z
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 20:26:13 -0500
From: "Liu, Changpeng" <changpeng.liu@intel.com>
Date: Tue, 12 Dec 2017 01:25:30 +0000
Message-ID: <FF7FC980937D6342B9D289F5F3C7C2625B5E5373@SHSMSX103.ccr.corp.intel.com>
References: <1512455239-8296-1-git-send-email-changpeng.liu@intel.com>
	<1512455239-8296-2-git-send-email-changpeng.liu@intel.com>
	<20171211133901.GA5962@stefanha-x1.localdomain>
In-Reply-To: <20171211133901.GA5962@stefanha-x1.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v6 1/4] vhost-user: add new vhost user
 messages to support virtio config space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "felipe@nutanix.com" <felipe@nutanix.com>, "Harris, James R" <james.r.harris@intel.com>



> -----Original Message-----
> From: Stefan Hajnoczi [mailto:stefanha@gmail.com]
> Sent: Monday, December 11, 2017 9:39 PM
> To: Liu, Changpeng <changpeng.liu@intel.com>
> Cc: qemu-devel@nongnu.org; pbonzini@redhat.com; mst@redhat.com;
> marcandre.lureau@redhat.com; felipe@nutanix.com; Harris, James R
> <james.r.harris@intel.com>
> Subject: Re: [PATCH v6 1/4] vhost-user: add new vhost user messages to su=
pport
> virtio config space
>=20
> On Tue, Dec 05, 2017 at 02:27:16PM +0800, Changpeng Liu wrote:
> > +* VHOST_USER_SET_CONFIG
> > +      Id: 25
> > +      Equivalent ioctl: N/A
> > +      Master payload: virtio device config space
> > +
> > +      Submitted by the vhost-user master when the Guest changes the vi=
rtio
> > +      device configuration space and also can be used for live migrati=
on
> > +      on the destination host. The vhost-user slave must check the fla=
gs
> > +      filed, and slaves MUST NOT accept SET_CONFIG for read-only
>=20
> s/filed/field/
Thanks.
>=20
> > +static int vhost_user_set_config(struct vhost_dev *dev, const uint8_t =
*config,
> > +                                 uint32_t offset, uint32_t size, uint3=
2_t flags)
> > +{
> > +    uint8_t *p;
> > +    bool reply_supported =3D virtio_has_feature(dev->protocol_features=
,
> > +                                              VHOST_USER_PROTOCOL_F_RE=
PLY_ACK);
> > +
> > +    VhostUserMsg msg =3D {
> > +        msg.request =3D VHOST_USER_SET_CONFIG,
> > +        msg.flags =3D VHOST_USER_VERSION,
> > +        msg.size =3D VHOST_USER_CONFIG_HDR_SIZE + size,
> > +    };
> > +
> > +    if (reply_supported) {
> > +        msg.flags |=3D VHOST_USER_NEED_REPLY_MASK;
> > +    }
> > +
> > +    msg.payload.config.offset =3D offset,
> > +    msg.payload.config.size =3D size,
> > +    msg.payload.config.flags =3D flags,
> > +    p =3D msg.payload.config.region;
> > +    memcpy(p, config + offset, size);
>=20
> This function can be made more general by changing the semantics of the
> config argument:
>=20
>   memcpy(p, config, size);
>=20
> Now the caller can pass just a single field instead of a whole 256-byte
> config buffer.  It might be clearer to name the argument "data" or
> "region" instead of "config" though.
Good suggestion, will change it.
>=20
> > @@ -1505,6 +1508,67 @@ void vhost_ack_features(struct vhost_dev *hdev,
> const int *feature_bits,
> >      }
> >  }
> >
> > +int vhost_dev_get_config(struct vhost_dev *hdev, uint8_t *config,
> > +                         uint32_t config_len)
> > +{
> > +    assert(hdev->vhost_ops);
> > +
> > +    if (hdev->vhost_ops->vhost_get_config) {
> > +        return hdev->vhost_ops->vhost_get_config(hdev, config, config_=
len);
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +int vhost_dev_set_config(struct vhost_dev *hdev, const uint8_t *config=
,
> > +                         uint32_t offset, uint32_t size, uint32_t flag=
s)
> > +{
> > +    assert(hdev->vhost_ops);
> > +
> > +    if (hdev->vhost_ops->vhost_set_config) {
> > +        return hdev->vhost_ops->vhost_set_config(hdev, config, offset,
> > +                                                 size, flags);
> > +    }
> > +
> > +    return 0;
> > +}
>=20
> Both vhost_dev_get_config() and vhost_dev_set_config() cannot fail
> silently.  The device will not work properly if the configuration space
> feature is not supported.
>=20
> Please make these functions return an error if the callback is NULL.
Ok, will add callback check.
>=20
> The vhost-blk code should also check that
> hdev->vhost_ops->vhost_set_config !=3D NULL during realize.  This way
> users see the error when adding the device instead of at runtime when
> the function gets called.
For vhost-blk, get_config is mandatory, but for set_config, it should depen=
d
on the feature bit: VIRTIO_BLK_F_CONFIG_WCE is enabled or not. Of course,
migration should be another case. So running time error process should be
okay.

Received: from eggs.gnu.org ([2001:4830:134:3::10]:37560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fDpSf-0006wc-RY
	for qemu-devel@nongnu.org; Wed, 02 May 2018 06:58:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fDpSb-0007LK-Ff
	for qemu-devel@nongnu.org; Wed, 02 May 2018 06:58:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50866 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fDpSb-0007L5-Ai
	for qemu-devel@nongnu.org; Wed, 02 May 2018 06:58:09 -0400
Date: Wed, 2 May 2018 11:58:05 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180502105805.GB2679@work-vm>
References: <1521515720-612046-1-git-send-email-mst@redhat.com>
	<1521515720-612046-32-git-send-email-mst@redhat.com>
	<CAFEAcA_kuyWHnqhcA-Zo5+q4u48dDLv4nxrEm5fFcbjZh9U6KQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAFEAcA_kuyWHnqhcA-Zo5+q4u48dDLv4nxrEm5fFcbjZh9U6KQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 31/50] vhost+postcopy: Register shared
 ufd with postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On 20 March 2018 at 03:17, Michael S. Tsirkin <mst@redhat.com> wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >
> > Register the UFD that comes in as the response to the 'advise' method
> > with the postcopy code.
> >
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  hw/virtio/vhost-user.c | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
>=20
> > @@ -835,8 +847,14 @@ static int vhost_user_postcopy_advise(struct vho=
st_dev *dev, Error **errp)
> >          error_setg(errp, "%s: Failed to get ufd", __func__);
> >          return -1;
> >      }
> > +    fcntl(ufd, F_SETFL, O_NONBLOCK);
>=20
> Hi; this would probably be more neatly done with
>        qemu_set_nonblock(ufd);
> unless you really wanted to clear the other fd flags.
> Among other things, it avoids Coverity producing a complaint
> that we didn't check the fcntl return value (though we seem
> to assume it can't fail in general, hence qemu_set_nonblock()
> returning NULL.) -- CID1390601, which I've marked as false-positive.

Fix posted.  To be honest, I probably hadn't realised/forgot that
this would nuke all the other flags.  I bet some of the others uses
are the same, and may be losing important flags like noexec.

Dave

> > -    /* TODO: register ufd with userfault thread */
> > +    /* register ufd with userfault thread */
> > +    u->postcopy_fd.fd =3D ufd;
> > +    u->postcopy_fd.data =3D dev;
> > +    u->postcopy_fd.handler =3D vhost_user_postcopy_fault_handler;
> > +    u->postcopy_fd.idstr =3D "vhost-user"; /* Need to find unique na=
me */
> > +    postcopy_register_shared_ufd(&u->postcopy_fd);
> >      return 0;
> >  }
>=20
> thanks
> -- PMM
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

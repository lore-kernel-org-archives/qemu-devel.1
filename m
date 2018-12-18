Received: from eggs.gnu.org ([2001:4830:134:3::10]:48029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gZKDC-0007Ul-W8
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 13:35:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gZKDB-0001JI-Hv
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 13:35:22 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38223)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gZKDA-00017N-2s
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 13:35:20 -0500
Received: by mail-wr1-x441.google.com with SMTP id v13so16947886wrw.5
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 10:35:18 -0800 (PST)
MIME-Version: 1.0
References: <20181126124250.29985-1-marcandre.lureau@redhat.com>
	<20181126124250.29985-2-marcandre.lureau@redhat.com>
	<20181210142956.wucn33osm7fxa27d@sirius.home.kraxel.org>
	<CAMxuvawUrZ=y-txTS86Tz3b-BYY05k4n-jBiY8+vO5e7AOkPKA@mail.gmail.com>
	<20181210183313-mutt-send-email-mst@kernel.org>
	<20181211074241.ovuharwewaw22ygq@sirius.home.kraxel.org>
	<20181211092944.GA921@redhat.com>
	<20181211135230-mutt-send-email-mst@kernel.org>
In-Reply-To: <20181211135230-mutt-send-email-mst@kernel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 18 Dec 2018 22:35:05 +0400
Message-ID: <CAJ+F1CKuoWWxLqZKQRU-g_144jX2bwsQJUzeW0W-QicNrbPfQw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 01/11] vhost-user: define
 conventions for vhost-user backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, "Hoffmann, Gerd" <kraxel@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

Hi

On Tue, Dec 11, 2018 at 10:56 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Dec 11, 2018 at 09:29:44AM +0000, Daniel P. Berrang=C3=A9 wrote:
> > On Tue, Dec 11, 2018 at 08:42:41AM +0100, Hoffmann, Gerd wrote:
> > >   Hi,
> > >
> > > > Right. The main issue is that we need to make sure only
> > > > in-tree devices are supported.
> > >
> > > Well, that is under debate right now, see:
> > > https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg04912.html
> >
> > I've previously been against the idea of external plugins for QEMU,
> > however, that was when the plugin was something that would be dlopen'd
> > by QEMU. That would cause our internal ABI to be exposed to 3rd parties
> > which is highly undesirable, even if they were open source to comply
> > with the license needs.
> >
> > When the plugin is a completely isolated process communicating with a
> > well defined protocol, it is not placing a significant burden on the
> > QEMU developers' ongoing maintainence, nor has problems with license
> > compliance. The main problem would come from debugging the combined
> > system as the external process is essentially a black box from QEMU's
> > POV. Downstream OS vendors are free to place restrictions on which
> > backend processes they'd be willing to support with QEMU, and upstream
> > is under no obligation to debug stuff beyond the QEMU boundary.
> >
> > We have already accepted that tradeoff with networking by supporting
> > vhost-user and have externals impls like DPDK, so I don't see a
> > compelling reason to try to restrict it for other vhost-user backends.
>
> OK seems to be more or less a rough concensus then.
>
> I wonder what's the approach wrt migration though.

The series doesn't take care of migration.

>
> Even the compatibility story about vhost-user isn't
> great, I would like to see something solid before
> we allow that.

To allow migration? vhost-user has partial support for migration
(dirty memory tracking), and there is also "[PATCH v2 for-4.0 0/7]
vhost-user-blk: Add support for backend reconnecting" - allowing the
backend to store some state, if I understand correctly, which could be
leveraged I guess...

But I don't think we should block this series because migration isn't
tackled here.

thanks


.

>
> Are we happy to just block live migration?
> For sure that's already the case with VFIO.
>
>
> > > > vhost-user by design
> > > > is for out of tree users. It needn't be hard,
> > > > maybe it's enough to just make qemu launch these processes
> > > > as opposed to connecting to them on command line.
> > >
> > > Not sure this is a good idea, with security being one of the motivati=
ng
> > > factors to move device emulation to other processes.  When libvirt
> > > launches the processes it can place them in separate sandboxes ...
> >
> > Yep, libvirt already turns on seccomp policies which forbid QEMU from
> > forking/execing anything, and we have no desire to go backwards here.
> > Any external processes have to be launched by libvirt ahead of time.
> >
> >
> > Regards,
> > Daniel
> > --
> > |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> > |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> > |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
>


--=20
Marc-Andr=C3=A9 Lureau

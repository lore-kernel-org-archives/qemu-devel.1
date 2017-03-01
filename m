Received: from eggs.gnu.org ([2001:4830:134:3::10]:50082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cj9m9-000415-6T
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 14:19:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cj9m7-0004Ok-Rn
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 14:19:01 -0500
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:33484)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cj9m7-0004Ni-Fq
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 14:18:59 -0500
Received: by mail-lf0-x241.google.com with SMTP id r36so4091991lfi.0
	for <qemu-devel@nongnu.org>; Wed, 01 Mar 2017 11:18:59 -0800 (PST)
MIME-Version: 1.0
References: <20170301163104.GJ10160@redhat.com>
	<20170301185414-mutt-send-email-mst@kernel.org>
	<1d155a66-8806-8792-b82d-4bebabcd4971@linux.vnet.ibm.com>
	<20170301191459-mutt-send-email-mst@kernel.org>
	<4022b3c9-56c3-7cea-928c-9e0e7d070d90@linux.vnet.ibm.com>
	<20170301173823.GO10160@redhat.com>
	<20170301194704-mutt-send-email-mst@kernel.org>
	<20170301181117.GR10160@redhat.com>
	<20170301201347-mutt-send-email-mst@kernel.org>
	<CAJ+F1CKM1JEqCv5mVUmP8E8WxEsjKY7zVTqqcTckvgmCDgmrEw@mail.gmail.com>
	<20170301185617.GT10160@redhat.com>
In-Reply-To: <20170301185617.GT10160@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 01 Mar 2017 19:18:46 +0000
Message-ID: <CAJ+F1CKxmeCWbVepKa3R4fv_gL03OYxA9=tROzDoR3bi7JCrHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 1/4] Provide support for the CUSE TPM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Stefan Berger <stefanb@us.ibm.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "SERBAN,
	CRISTINA" <cs1731@att.com>, "Xu, Quan" <quan.xu@intel.com>, "silviu.vlasceanu@gmail.com" <silviu.vlasceanu@gmail.com>, "hagen.lauer@huawei.com" <hagen.lauer@huawei.com>, "SHIH,
	CHING C" <cs1815@att.com>

On Wed, Mar 1, 2017 at 10:56 PM Daniel P. Berrange <berrange@redhat.com>
wrote:

> On Wed, Mar 01, 2017 at 06:32:19PM +0000, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Wed, Mar 1, 2017 at 10:20 PM Michael S. Tsirkin <mst@redhat.com>
> wrote:
> >
> > >
> > > > You're also tieing the code
> > > > into the QEMU release cycle, again for no tangible benefit.
> > >
> > > No need for ABI stability would be the benefit.
> > >
> >
> > We are talking about the control channel ABI (the data channel is using
> TCG
> > defined command streams afaict - don't remember what it is called)
> >
> >
> > >
> > > > Conceptually
> > > > swtpm does not depend on, or require, QEMU to be useful - it can ha=
ve
> > > > other non-QEMU consumers - bundling with QEMU is not helpful there.
> > >
> > > Maybe it could but it isn't.
> > >
> >
> > Right, it would be reasonable to have qemu provide it's own private
> "swtpm"
> > (linking with libtpms, doing most of the job), that way it wouldn't hav=
e
> to
> > rely on a stable ABI (as long as the process isn't shared across
> different
> > qemu versions, which should be quite easy to achieve)
>
> I think we need to expect to have a stable ABI no matter what. During
> upgrade cycles, it is desirable to be able to upgrade the swtpm process
> assocatied with a running VM. Whether this is done by restarting the
> process & having QEMU reconnect, or by re-exec'ing swtpm and keeping the
> FD open, you still end up with newer swtpm talking to an older QEMU. Or
>

I am not sure why this is required. You could require that both qemu &
helper process are restarted in this case so they stay in sync, no?


> conversely you might have setup swtpm processes to populate a number of
> CUSE devices, and then later launch QEMU binaries to connect to them - at
>

I would rather avoid CUSE device with this private qemu helper process.


> which point there's no guarantee the QEMU version hasn't been upgraded -
> or the user could have requested a custom QEMU binary to virt-install,
> etc.
>

The point is to have the qemu binary tight with the helper process. If they
are incompatible, you broke your installation, it should fail to start.

--=20
Marc-Andr=C3=A9 Lureau

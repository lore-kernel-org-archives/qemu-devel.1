Received: from eggs.gnu.org ([2001:4830:134:3::10]:49712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cvouk-00044e-0F
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 13:40:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cvoug-0006ow-5T
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 13:40:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48512)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cvouf-0006oU-W8
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 13:40:10 -0400
Date: Wed, 5 Apr 2017 18:39:55 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170405173955.GB25291@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170311132256.22951-1-marcandre.lureau@redhat.com>
	<20170311132256.22951-18-marcandre.lureau@redhat.com>
	<20170405161256.GA25291@redhat.com>
	<2f015621-19aa-d70b-6103-fef6514fcd7e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2f015621-19aa-d70b-6103-fef6514fcd7e@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 17/21] virtio-channel: parse qga stream for
 VMDUMP_INFO event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, mdroth@linux.vnet.ibm.com, armbru@redhat.com, qemu-devel@nongnu.org, anderson@redhat.com, pbonzini@redhat.com, lersek@redhat.com

On Wed, Apr 05, 2017 at 12:06:56PM -0500, Eric Blake wrote:
> On 04/05/2017 11:12 AM, Daniel P. Berrange wrote:
> > On Sat, Mar 11, 2017 at 05:22:52PM +0400, Marc-Andr=C3=A9 Lureau wrot=
e:
> >> On virtio channel "org.qemu.guest_agent.0", parse the json stream un=
til
> >> the VMDUMP_INFO is received and retrieve the dump details.
> >>
>=20
> >=20
> > so we just continually feed data into the json parser until we see th=
e
> > event we care about....
> >=20
> > What kind of denial of service protection does our JSON parser have. =
Now
> > that QEMU is directly parsing JSON from QEMU guest agent, it is expos=
ed
> > to malicious attack by the guest agent.
>=20
> Our JSON parser rejects input that exceeds various limits:
>=20
> json-lexer.c:
> #define MAX_TOKEN_SIZE (64ULL << 20)
>=20
> json-streamer.c:
> #define MAX_TOKEN_SIZE (64ULL << 20)
> #define MAX_TOKEN_COUNT (2ULL << 20)
> #define MAX_NESTING (1ULL << 10)
>=20
> >=20
> > eg what happens if the 'vmcoreinfo' string in the JSON doc received f=
rom
> > the guest ends up being 10GB in size ? Is that going to cause our JSO=
N
> > parser to allocate QString which is 10GB in size which we'll further
> > try to strdup just below too...
>=20
> The parser will have rejected the guest data long before the 10GB mark.
> But our error recovery from that rejection may not be ideal...

Ok, good, we should be pretty much ok then


Regards,
Daniel
--=20
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange=
/ :|
|: http://libvirt.org              -o-             http://virt-manager.or=
g :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr=
/ :|

Received: from eggs.gnu.org ([2001:4830:134:3::10]:44870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <JBeulich@suse.com>) id 1fJgB1-0002iV-Tg
	for qemu-devel@nongnu.org; Fri, 18 May 2018 10:16:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <JBeulich@suse.com>) id 1fJgAs-00022v-4N
	for qemu-devel@nongnu.org; Fri, 18 May 2018 10:16:11 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:50630)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <JBeulich@suse.com>) id 1fJgAr-000224-RF
	for qemu-devel@nongnu.org; Fri, 18 May 2018 10:16:02 -0400
Message-Id: <5AFEE01F02000078001C4100@prv1-mh.provo.novell.com>
Date: Fri, 18 May 2018 08:15:59 -0600
From: "Jan Beulich" <JBeulich@suse.com>
References: <1526648406-1746-1-git-send-email-paul.durrant@citrix.com>
	<5AFED64102000078001C4069@prv1-mh.provo.novell.com>
	<f4620ef5cd6d45b58bb4ef29259c6ee9@AMSPEX02CL03.citrite.net>
In-Reply-To: <f4620ef5cd6d45b58bb4ef29259c6ee9@AMSPEX02CL03.citrite.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: Re: [Qemu-devel] [Xen-devel] [PATCH v2] xen-hvm: stop faking I/O to
 access PCI config space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: anthony.perard@citrix.com, Roger Pau Monne <roger.pau@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel <xen-devel@lists.xenproject.org>, qemu-devel@nongnu.org, ehabkost@redhat.com, marcel@redhat.com, mst@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

>>> On 18.05.18 at 15:51, <Paul.Durrant@citrix.com> wrote:
>> Sent: 18 May 2018 14:34
>> To: Paul Durrant <Paul.Durrant@citrix.com>
>> >>> On 18.05.18 at 15:00, <paul.durrant@citrix.com> wrote:
>> > +    QLIST_FOREACH(xendev, &state->dev_list, entry) {
>> > +        unsigned int i;
>> > +        uint32_t tmp;
>> > +
>> > +        if (xendev->sbdf !=3D sbdf) {
>> > +            continue;
>> > +        }
>> > +
>> > +        if (!req->data_is_ptr) {
>> > +            if (req->dir =3D=3D IOREQ_READ) {
>> > +                for (i =3D 0; i < req->count; i++) {
>> > +                    rw_config_req_item(xendev, req, i, &tmp);
>> > +                    req->data =3D tmp;
>> > +                }
>> > +            } else if (req->dir =3D=3D IOREQ_WRITE) {
>> > +                for (i =3D 0; i < req->count; i++) {
>> > +                    tmp =3D req->data;
>> > +                    rw_config_req_item(xendev, req, i, &tmp);
>> > +                }
>> > +            }
>>=20
>> Wouldn't it be more sensible to fail req->count !=3D 1 requests here?
>>=20
>=20
> I'm wondering whether we'd want to handle count > 1 once we allow =
MMCONFIG=20
> accesses though. I guess it would be easier just to defer that.

For the data_is_ptr case - sure. But here? Or wait - are you thinking =
about
REP STOS (and the relatively useless REP LODS)?

Jan

Received: from eggs.gnu.org ([2001:4830:134:3::10]:43766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nia.alarie@gmail.com>) id 1evlnr-0007Rn-AP
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:25:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nia.alarie@gmail.com>) id 1evlnp-0000kh-VK
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:25:27 -0400
Received: from mail-lf0-x22b.google.com ([2a00:1450:4010:c07::22b]:37051)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nia.alarie@gmail.com>)
	id 1evlnp-0000kD-LK
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:25:25 -0400
Received: by mail-lf0-x22b.google.com with SMTP id y19-v6so29410617lfd.4
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 08:25:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180312142131.397c5ba1@bahia.lan>
References: <20180311201239.25506-1-nia.alarie@gmail.com>
	<486e1b60-e453-c3de-040b-8b2951ddf3a5@redhat.com>
	<20180312140229.66930d5d@bahia.lan> <20180312130829.GR3493@redhat.com>
	<20180312142131.397c5ba1@bahia.lan>
From: nee <nia.alarie@gmail.com>
Date: Tue, 13 Mar 2018 15:25:22 +0000
Message-ID: <CA+k8WDrpNMcDSqSy_L3Ucyj++Kvz2AQR_DsbHAdOiPbW9WVn5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] 9p: Convert use of atoi to qemu_strtol to
 allow error checking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>, Jim Mussared <jim@groklearning.com>, Joel Stanley <joel@jms.id.au>

On Mon, Mar 12, 2018 at 1:21 PM, Greg Kurz <groug@kaod.org> wrote:
> On Mon, 12 Mar 2018 13:08:29 +0000
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
>
>> On Mon, Mar 12, 2018 at 02:02:29PM +0100, Greg Kurz wrote:
>> > On Mon, 12 Mar 2018 07:12:52 -0500
>> > Eric Blake <eblake@redhat.com> wrote:
>> >
>> > > On 03/11/2018 03:12 PM, Nia Alarie wrote:
>> > > > Signed-off-by: Nia Alarie <nia.alarie@gmail.com>
>> > > > ---
>> > > >   hw/9pfs/9p.c | 12 ++++++++++--
>> > > >   1 file changed, 10 insertions(+), 2 deletions(-)
>> > > >
>> > >
>> > > >       } else if (perm & P9_STAT_MODE_LINK) {
>> > > > -        int32_t ofid =3D atoi(extension.data);
>> > > > -        V9fsFidState *ofidp =3D get_fid(pdu, ofid);
>> > > > +        long ofid;
>> > > > +        V9fsFidState *ofidp;
>> > > > +
>> > > > +        if (qemu_strtol(extension.data, NULL, 10, &ofid) ||
>> > > > +            ofid > INT32_MAX || ofid < INT32_MIN) {
>> > >
>> > > Dan has a pending patch that will add qemu_strtoi, which might be a
>> > > nicer fit for this situation:
>> > >
>> > > https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg00952.html
>> > >
>> > > int32_t is not necessarily int, but all platforms that compile qemu =
have
>> > > 'int32_t' and 'int' both at 32 bits, so it's simpler to change to 'i=
nt
>> > > ofid' and use Dan's function than it is to parse to long and then do
>> > > bounds checking.  Except that Dan still needs to post an updated ver=
sion
>> > > of his patch...
>> > >
>> >
>> > I wasn't aware of Dan's patch but I agree it would result in a nicer
>> > change for 9p. This being said, tomorrow is soft freeze... is there
>> > a chance Dan's patch reaches master anytime soon ?
>>
>> I just sent an update of my series. If it gets acked by Eric, I'd be abl=
e
>> to send a pull request today.
>>
>> Regards,
>> Daniel
>
> Great !
>
> Nia,
>
> Could you please respin your patch on top of Daniel's series, using
> qemu_strtoui() ?
>
> Thanks,
>
> --
> Greg

I'm a bit unclear on how this works so I thought I'd ask here before I
send any more patches - this is CCed to my mentors as well. It's
"tomorrow" now, but I don't understand how soft freezes work or the
process beyond "I send this patch to qemu-devel and people say if I
should re-send it with changes, or that it's been accepted" :)

There are several more conversions from ato* to qemu_strto* I'd like
to submit from now on. Should I send them as using qemu_strtol now, to
get them "out there" before my own personal deadlines, and send
further patches to convert them to qemu_strtoi later, or should I
submit patches that use qemu_strtoi? I'm not sure of the current
status of Daniel's patches.

Thank you.

Received: from eggs.gnu.org ([2001:4830:134:3::10]:53666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ctneN-0005Ea-R4
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 23:55:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ctneK-0005Hp-Oo
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 23:54:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcody@redhat.com>) id 1ctneK-0005Hi-GX
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 23:54:56 -0400
Date: Thu, 30 Mar 2017 23:54:52 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170331035452.GL22342@localhost.localdomain>
References: <058D52979F67BF47BCD9EA78EAECA6DC7779F2D5@SESTOEX04.enea.se>
	<de0d3d40-833b-f24b-7689-b23eb9c78244@redhat.com>
	<058D52979F67BF47BCD9EA78EAECA6DC7779F35F@SESTOEX04.enea.se>
	<153e27df-ed6d-f562-9831-9790b584beb1@redhat.com>
	<fd465426-e057-a68b-de02-1c244132ecc8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd465426-e057-a68b-de02-1c244132ecc8@redhat.com>
Subject: Re: [Qemu-devel] rbd: Possible regression in 2.9 RCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Alexandru Avadanii <Alexandru.Avadanii@enea.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, svc-armband <armband@enea.com>

On Thu, Mar 30, 2017 at 09:08:20PM -0500, Eric Blake wrote:
> On 03/30/2017 08:22 PM, Eric Blake wrote:
> > On 03/30/2017 08:05 PM, Alexandru Avadanii wrote:
> >> c7cacb3e7a2e9fdf929c993b98268e4179147cbb is the first bad commit
> >>     block/rbd: parse all options via bdrv_parse_filename
> > 
> > Yep, my bisect finished about 2 minutes after your email on the same
> > spot. I'm working on a patch.  I can reproduce the problem with a mere:
> > 
> > ./x86_64-softmmu/qemu-system-x86_64 -nodefaults -nographic -qmp stdio
> > -drive
> > 'file=rbd:volumes/volume-ea141b5c-cdb3-4765-910d-e7008b209a70:id=compute:key=AQAVkvxXAAAAABAA9ZxWFYdRmV+DSwKr7BKKXg==:auth_supported=cephx\;none:mon_host=192.168.1.2\:6789,format=raw,if=none,id=drive-virtio-disk0,serial=ea141b5c-cdb3-4765-910d-e7008b209a70,cache=writeback'
> > 
> > the good behavior (on my setup) just hangs trying to connect to a
> > non-existent machine, the bad behavior gets rather-badly misparsed
> > (splitting the escaped : in the host:port portion as if the port were
> > the next key-value pair) resulting in an instant error message. I don't
> > have an actual RBD setup for testing the fix, but will cc you on the
> > patch that I propose once I have something.
> 
> I found the culprit, but the patch is taking me longer.
> 
> We are unescaping key="mon_host", value="192.168.1.2\:6789" when we
> first parse the key/value pairs in qemu_rbd_parse_filename(), then we
> slam the unescaped values back into a single string with ':' separators
> resulting in "mon_host=192.168.1.2:6789" for stuffing through the QDict,
> then we pass that string BACK through qemu_rbd_next_tok() inside
> qemu_rbd_set_keypairs(), and since we no longer have the \: escape, we
> are trying to treat 6789 as a new key on the second pass.  Moral of the
> story: don't parse stuff twice.
> 
> My patch will be to use a QList instead of a QString for the hidden
> "=keyvalue-pairs" object that we use to pass things around between
> parsing the filename and actually passing parameters to RBD, matching
> the fact that we already have this telling comment:
> 
>             /* FIXME: This is pretty ugly, and not the right way to do this.
>              *        These should be contained in a structure, and then
>              *        passed explicitly as individual key/value pairs to
>              *        rados.  Consider this legacy code that needs to be
>              *        updated. */


Ugh.  Yep, I just got done coming to the same conclusion, only to hop on the
email list to see that you did as well.  A QList sounds like a good choice.

Jeff

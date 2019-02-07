Received: from eggs.gnu.org ([209.51.188.92]:59850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1gre0V-00089q-Nx
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 02:22:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1gre0T-00032w-TW
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 02:21:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:9753)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1gre0R-00030x-R6
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 02:21:56 -0500
Date: Thu, 7 Feb 2019 02:21:52 -0500 (EST)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <1385614518.70345867.1549524112156.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190206162901.GW12331@redhat.com>
References: <20190129062801.15799-1-pagupta@redhat.com>
	<CAJ+F1CKenN+Ujg1ajtgixwJabir5+zfBAV3r=4LBqodpqHd8iA@mail.gmail.com>
	<20190206162901.GW12331@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] chardev: Avoid adding duplicate chardev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?utf-8?Q?P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, QEMU <qemu-devel@nongnu.org>, xiaohli@redhat.com, Paolo Bonzini <pbonzini@redhat.com>


Hi Daniel, Marc-Andre,

Thanks for your reply. Please find my reply inline.

> > > Hotplugging existing char chardev with qmp, dereferences(removes)
> > > existing chardev. This patch avoids adding a chardev if a chardev
> > > with same id exists.
> > 
> > As you pointed out, if you attempt to add a chardev with an existing
> > ID, you get an error:
> > 
> > {"execute":"chardev-add","arguments":{"id":"charchannel1","backend":{"type":"socket","data":{"addr":{"type":"unix",
> > "data": {"path": "/tmp/helloworld1"}}}}}}
> > {"return": {}}
> > {"execute":"chardev-add","arguments":{"id":"charchannel1","backend":{"type":"socket","data":{"addr":{"type":"unix",
> > "data": {"path": "/tmp/helloworld1"}}}}}}
> > {"error": {"class": "GenericError", "desc": "attempt to add duplicate
> > property 'charchannel1' to object (type 'container')"}}
> > 
> > 
> > But the existing chardev is left untouched.
> > 
> > However, since unix socket chardev will delete existing file and
> > rebind (this is not always a good idea, but people seem to prefer
> > that)
> > the rebound socket is removed on error cleanup.
> > 
> > 
> > I am not sure this is a bug tbh.
> > 
> > Your solution to check for duplicate ID upfront is ok. But any other
> > later error path could have the same "bug" effect of removing existing
> > chardev because of the overwrite socket creation.
> 
> Checking the ID is not a useful fix IMHO. Someone could just as easily
> send 2 commands with different IDs and the same socket path.
> 
> A more accurate fix would be to iterate over existing chardevs and check
> whether any of them clash, but even that is useless if you have two
> separate QEMU instances and both try to use the same UNIX socket path.
> To deal with that you need to start taking out fcntl locks to ensure
> real mutual exclusion.

The reason we are already throwing error "attempt to add duplicate property"
implies we are considering "id" as primary key? Even if we throw the error
existing chardev should work as before. But this is not the case right now, 
it just deletes the existing chardev after error.  

Thanks,
Pankaj

> 
> I think I'd really just call this user error and do nothing
> 
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange
> |:|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com
> |:|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange
> |:|
> 

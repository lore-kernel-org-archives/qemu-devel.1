Received: from eggs.gnu.org ([2001:4830:134:3::10]:37056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fiMEh-0007UA-7y
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 12:02:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fiMEe-0000pp-Aw
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 12:01:59 -0400
Date: Wed, 25 Jul 2018 17:01:44 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180725160144.GJ12855@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180725151011.25951-1-armbru@redhat.com>
	<5e713599-997f-7dda-917c-80902f6ef328@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5e713599-997f-7dda-917c-80902f6ef328@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH] rbd: Don't convert keypairs to JSON
 and back
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, kwolf@redhat.com, jdurgin@redhat.com, jcody@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

On Wed, Jul 25, 2018 at 10:56:48AM -0500, Eric Blake wrote:
> On 07/25/2018 10:10 AM, Markus Armbruster wrote:
> > qemu_rbd_parse_filename() builds a keypairs QList, converts it to JSON, and
> > stores the resulting QString in a QDict.
> > 
> > qemu_rbd_co_create_opts() and qemu_rbd_open() get the QString from the
> > QDict, pass it to qemu_rbd_set_keypairs(), which converts it back into
> > a QList.
> > 
> > Drop both conversions, store the QList instead.
> > 
> > This affects output of qemu-img info.  Before this patch:
> > 
> >      $ qemu-img info rbd:rbd/testimg.raw:mon_host=192.168.15.180:rbd_cache=true:conf=/tmp/ceph.conf
> >      [junk printed by Ceph library code...]
> >      image: json:{"driver": "raw", "file": {"pool": "rbd", "image": "testimg.raw", "conf": "/tmp/ceph.conf", "driver": "rbd", "=keyvalue-pairs": "[\"mon_host\", \"192.168.15.180\", \"rbd_cache\", \"true\"]"}}
> >      [more output, not interesting here]
> > 
> > After this patch, we get
> > 
> >      image: json:{"driver": "raw", "file": {"pool": "rbd", "image": "testimg.raw", "conf": "/tmp/ceph.conf", "driver": "rbd", "=keyvalue-pairs": ["mon_host", "192.168.15.180", "rbd_cache", "true"]}}
> > 
> > The value of member "=keyvalue-pairs" changes from a string containing
> > a JSON array to that JSON array.  That's an improvement of sorts.  However:
> > 
> > * Should "=keyvalue-pairs" even be visible here?  It's supposed to be
> >    purely internal...
> 
> I'd argue that since it is supposed to be internal (as evidenced by the
> leading '=' that does not name a normal variable), changing it doesn't hurt
> stability. But yes, it would be nicer if we could filter it entirely so that
> it does not appear in json: output, if it doesn't truly affect the contents
> that the guest would see.

If it appears in the json: output, then that means it could get written
into qcow2 headers as a backing file name, which would make it ABI
sensitive. This makes it even more important to filter it if it is supposed
to be internal only, with no ABI guarantee.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

Received: from eggs.gnu.org ([2001:4830:134:3::10]:58323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cagki-00044U-VT
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 05:42:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cagkf-0002Ua-Aj
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 05:42:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cagkf-0002UV-4e
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 05:42:29 -0500
Date: Mon, 6 Feb 2017 10:42:22 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170206104222.GG3029@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170125161417.31949-1-berrange@redhat.com>
	<20170125161417.31949-2-berrange@redhat.com>
	<20170204154801.wdg35axz7ffvvz43@perseus.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170204154801.wdg35axz7ffvvz43@perseus.local>
Subject: Re: [Qemu-devel] [PATCH v4 1/8] make: move top level dir to end of
 include search path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, =?utf-8?B?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>

On Sat, Feb 04, 2017 at 05:48:01PM +0200, Alberto Garcia wrote:
> On Wed, Jan 25, 2017 at 04:14:10PM +0000, Daniel P. Berrange wrote:
> 
> > One final complication is that the absolute '-I$(BUILD_DIR)/$(@D)'
> > will sometimes end up pointing to a non-existant directory if
> > that sub-dir does not have any target-independant files to be
> > built. Rather than try to dynamically filter this, a simple
> > 'mkdir' ensures $(BUILD_DIR)/$(@D) is guaranteed to exist at
> > all times.
> > 
> > @@ -359,6 +374,7 @@ define unnest-vars
> >                  $(eval $(o:%.mo=%$(DSOSUF)): module-common.o $($o-objs)),
> >                  $(error $o added in $v but $o-objs is not set)))
> >          $(shell mkdir -p ./ $(sort $(dir $($v))))
> > +        $(shell cd $(BUILD_DIR) && mkdir -p ./ $(sort $(dir $($v))))
> >          # Include all the .d files
> >          $(eval -include $(patsubst %.o,%.d,$(patsubst %.mo,%.d,$($v))))
> >          $(eval $v := $(filter-out %/,$($v))))
> 
> After this change building QEMU leaves a lot of empty directories in
> the parent directory:
> 
> $ mkdir empty_dir
> $ cd empty_dir
> $ git clone https://github.com/qemu/qemu
> $ cd qemu
> $ ./configure ...
> $ ls ..
> qemu
> $ make
> $ ls ..
> audio     chardev  fsdev  linux-user  net   qom     target
> backends  crypto   hw     migration   qapi  replay  ui
> block     disas    io     nbd         qemu  slirp   util

Yuk, that's a horrible mistake, of course missed because git status
won't tell you about stuff creatd in the parent of the repo :-(

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|

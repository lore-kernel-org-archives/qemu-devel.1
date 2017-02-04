Received: from eggs.gnu.org ([2001:4830:134:3::10]:55056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ca2aA-0005V8-TF
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 10:48:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ca2a7-0007Li-1B
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 10:48:58 -0500
Received: from smtp3.mundo-r.com ([212.51.32.191]:19472 helo=smtp4.mundo-r.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ca2a6-00074f-ID
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 10:48:54 -0500
Date: Sat, 4 Feb 2017 17:48:01 +0200
From: Alberto Garcia <berto@igalia.com>
Message-ID: <20170204154801.wdg35axz7ffvvz43@perseus.local>
References: <20170125161417.31949-1-berrange@redhat.com>
	<20170125161417.31949-2-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170125161417.31949-2-berrange@redhat.com>
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, =?utf-8?B?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>

On Wed, Jan 25, 2017 at 04:14:10PM +0000, Daniel P. Berrange wrote:

> One final complication is that the absolute '-I$(BUILD_DIR)/$(@D)'
> will sometimes end up pointing to a non-existant directory if
> that sub-dir does not have any target-independant files to be
> built. Rather than try to dynamically filter this, a simple
> 'mkdir' ensures $(BUILD_DIR)/$(@D) is guaranteed to exist at
> all times.
> 
> @@ -359,6 +374,7 @@ define unnest-vars
>                  $(eval $(o:%.mo=%$(DSOSUF)): module-common.o $($o-objs)),
>                  $(error $o added in $v but $o-objs is not set)))
>          $(shell mkdir -p ./ $(sort $(dir $($v))))
> +        $(shell cd $(BUILD_DIR) && mkdir -p ./ $(sort $(dir $($v))))
>          # Include all the .d files
>          $(eval -include $(patsubst %.o,%.d,$(patsubst %.mo,%.d,$($v))))
>          $(eval $v := $(filter-out %/,$($v))))

After this change building QEMU leaves a lot of empty directories in
the parent directory:

$ mkdir empty_dir
$ cd empty_dir
$ git clone https://github.com/qemu/qemu
$ cd qemu
$ ./configure ...
$ ls ..
qemu
$ make
$ ls ..
audio     chardev  fsdev  linux-user  net   qom     target
backends  crypto   hw     migration   qapi  replay  ui
block     disas    io     nbd         qemu  slirp   util

Berto

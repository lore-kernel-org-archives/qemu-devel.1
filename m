Received: from eggs.gnu.org ([2001:4830:134:3::10]:57858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dPqQU-0005CJ-VT
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 09:21:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dPqQU-0004I8-1b
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 09:21:06 -0400
Date: Tue, 27 Jun 2017 14:20:40 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170627132040.GH13634@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1498566850-7934-1-git-send-email-pl@kamp.de>
	<1498566850-7934-2-git-send-email-pl@kamp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1498566850-7934-2-git-send-email-pl@kamp.de>
Subject: Re: [Qemu-devel] [PATCH 1/4] block/qcow2: add compression_algorithm
 create option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: qemu-block@nongnu.org, kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org, lersek@redhat.com

On Tue, Jun 27, 2017 at 02:34:07PM +0200, Peter Lieven wrote:
> this patch adds a new compression_algorithm option when creating qcow2 images.
> The current default for the compresison algorithm is zlib and zlib will be
> used when this option is omitted (like before).
> 
> If the option is specified e.g. with:
> 
>  qemu-img create -f qcow2 -o compression_algorithm=zlib image.qcow2 1G

IMHO we should introduce a nested struct "compress" struct to hold the format
name, and any other format specific arguments, in a way that maps nicely to
any future QAPI representmatch of create options. eg

{ 'enum': 'BlockdevQcow2CompressFormat',
  'data': [ 'zlib', 'lzo' ] }

{ 'union': 'BlockdevQcow2Compress',
  'base': { 'format': 'BlockdevQcow2CompressFormat' },
  'discriminator': 'format',
  'data': { 'zlib': 'BlockdevQcow2CompressZLib',
            'lzo': 'BlockdevQcow2CompressLZO'} }

so it would map to

 qemu-img create -f qcow2 -o compress.format=zlib image.qcow2 1G

and let us have other compress.XXXX options specific to each format

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

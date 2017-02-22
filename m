Received: from eggs.gnu.org ([2001:4830:134:3::10]:60005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cgZAf-0007Qq-Ri
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 10:49:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cgZAd-0007N3-RV
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 10:49:37 -0500
Date: Wed, 22 Feb 2017 15:49:25 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170222154925.GT28937@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170221115512.21918-1-berrange@redhat.com>
	<20170221115512.21918-3-berrange@redhat.com>
	<20170222151833.GM4112@noname.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170222151833.GM4112@noname.str.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 02/18] block: add ability to set a
 prefix for opt names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>

On Wed, Feb 22, 2017 at 04:18:33PM +0100, Kevin Wolf wrote:
> Am 21.02.2017 um 12:54 hat Daniel P. Berrange geschrieben:
> > When integrating the crypto support with qcow/qcow2, we don't
> > want to use the bare LUKS option names "hash-alg", "key-secret",
> > etc. We want to namespace them "luks-hash-alg", "luks-key-secret"
> > so that they don't clash with any general qcow options at a later
> > date.
> 
> Or maybe "luks.key-secret", i.e. actually embed the LUKS options QAPI
> type into the qcow2 one? In that case, maybe qdict_extract_subqdict()
> can even be used before calling into this, so that we don't have to
> write a QemuOpts version of the function.

Yeah, the use of '-' vs '.'  is a significant decision point from
a QAPI modelling POV. Currently as you see from earlier patch, I just
add 'luks-key-secret' straight into BlockdevOptionsQcow2. ie I duplicate
fields from QCryptoBlockOptionsLUKS straight into BlockdevOptionsQcow2.
Likewise for fields from QCryptoBlockOptionsQCow.

If we used '.', we could potentially have BlockdevOptionsQcow2 directly
reference the QCryptoBlockOptionsLUKS & QCryptoBlockOptionsQCow structs.

As a point of reference though, we didn't do this for the standalone
'luks' block driver - BlockdevOptionsLUKS contains a copy of the
fields from QCryptoBlockOptionsLUKS because it needs to add
inheritance from BlockdevOptionsGenericFormat.

Both approaches have pluses & minuses and I don't have a particularly
strong opinion either way, so interested to hear what others thing.

> However, the only option I can see at the end of this series in
> BlockdevOptionsQcow2 is luks-key-secret, so what happened with this
> plan?
> 
> And if we really have only luks-key-secret (and that not in a separate
> sub-dict), I don't really see the need to have separate aes-key-secret
> and luks-key-secret options.

Currently, all except the key-secret are create time options, not
runtime and blockdev hasn't qapi'ified create time options. So the
bits like luks-cipher-alg, luks-cipher-mode, etc don't appear in
the QAPI schema, only the QemuOpts runtime_opts variable.

That both the legacy AES & LUKS modes only have a single runtime
option is just a co-incidence that is likely to be a temporary
state of affairs. It is quite possible that we'll gain more runtime
LUKS options in the future. For example, options to specify which
precise keyslot to load, or to provide the name of a separate image
containing a standalone luks header, etc.

Hence, I wanted to have separation between the legacy AES & LUKS
namespaces, to make it clear what applies to what scenario.

> > Reviewed-by: Max Reitz <mreitz@redhat.com>
> > Reviewed-by: Alberto Garcia <berto@igalia.com>
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> 
> Having said all that, while I'm not sure if the goal of the patch is
> completely right, it does seem to correctly implement what it promises.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|

Received: from eggs.gnu.org ([2001:4830:134:3::10]:37650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <piotr.jerzy.jurkiewicz@gmail.com>)
	id 1ejGjM-0008Hu-1e
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 22:49:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <piotr.jerzy.jurkiewicz@gmail.com>)
	id 1ejGjH-00075w-6G
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 22:49:08 -0500
Received: from mail-lf0-x230.google.com ([2a00:1450:4010:c07::230]:43486)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <piotr.jerzy.jurkiewicz@gmail.com>)
	id 1ejGjG-00075C-UA
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 22:49:03 -0500
Received: by mail-lf0-x230.google.com with SMTP id o89so5799894lfg.10
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 19:49:02 -0800 (PST)
Received: from [192.168.1.100] (static-202-152.is.net.pl. [217.144.202.152])
	by smtp.googlemail.com with ESMTPSA id
	s185sm100103lfs.71.2018.02.06.19.48.59 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 06 Feb 2018 19:48:59 -0800 (PST)
From: Piotr Jurkiewicz <piotr.jerzy.jurkiewicz@gmail.com>
Message-ID: <a54566c9-a54d-4d7f-35e3-6f94ae99bc06@gmail.com>
Date: Wed, 7 Feb 2018 04:48:57 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] Allow to use virtfs as overlayfs upper dir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi,

in order to obtain Docker-like experience I am trying to set up 
overlayfs merged directory inside VM. Both upper and lower directories 
are mounted with virtfs/9pfs from outside of the VM. However, current 
implementation of virtfs makes its usage as upper filesystem impossible.

1. Upper filesystem must support the creation of trusted.* extended 
attributes.

9pfs has support for getting/setting xattrs, but calls operating on 
attributes other than user.* and system.posix_acl_* are dropped.

2. Upper filesystem must provide valid d_type in readdir responses.

This works, but only in case of 'passtrough' and 'none' security models. 
In the case of 'mapped-xattr' and 'mapped-file' models, d_type is being 
zeroes to DT_UNKNOWN during readdir() call.

All these limitations can be resolved pretty easily, but requires some 
design decisions. I can prepare appropriate patches.

Ad. 1.

Why are operations on attributes other than than user.* and 
system.posix_acl_* forbidden? Is this due to security reasons?

If so, can we map all of them to user.virtfs namespace, similarly as 
system.posix_acl_* are being mapped to user.virtfs.system.posix_acl_* in 
'mapping' mode already? This way any trusted/security/system attributes 
will be effective only when mounted via virtfs inside VM.

Ad. 2.

local_readdir() can fill entry->d_type with the right DT_* value by 
obtaining file type from mapping and translating it with IFTODT() macro. 
This would, however, require reading 'user.virtfs.mode' for each 
direntry during readdir() call, what can affect performance. If so, this 
behavior would probably need to be controlled with some runtime option.

'mapped-xattr' and 'mapped-file' models are essential for running qemu 
with overlayfs as non-root, because overlayfs creates device nodes, what 
is possible for unprivileged user only with these models.

I am looking forward for your opinions.

Piotr

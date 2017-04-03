Received: from eggs.gnu.org ([2001:4830:134:3::10]:34151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cv076-0003SK-3F
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 07:25:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cv072-0000K2-9L
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 07:25:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cv072-0000Iy-0T
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 07:25:32 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0057061D26
	for <qemu-devel@nongnu.org>; Mon,  3 Apr 2017 11:25:31 +0000 (UTC)
Date: Mon, 3 Apr 2017 12:25:25 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170403112525.GO2768@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <a438ce0a-3035-1b2e-0d16-296ee930ed35@redhat.com>
	<e6621b99-a980-dc61-b267-590eb08923c0@redhat.com>
	<59a3aed6-e1cf-a601-4369-1a7cd74500cc@redhat.com>
	<20170324035537.GA22342@localhost.localdomain>
	<87fui3yx0y.fsf@dusky.pond.sub.org>
	<20170324124213.GC22342@localhost.localdomain>
	<89101331-9bba-fb6c-42a1-dfce7775fe4c@redhat.com>
	<20170324141025.GE15423@localhost.localdomain>
	<2c25aa1c-3832-e8a6-4bfa-004a79a10c77@redhat.com>
	<87h92ffeg4.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h92ffeg4.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH for-2.9 4/5] rbd: Peel off redundant
 RbdAuthMethod wrapper struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, kwolf@redhat.com, jdurgin@redhat.com, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, mreitz@redhat.com, dillaman@redhat.com

On Mon, Mar 27, 2017 at 07:58:51AM +0200, Markus Armbruster wrote:
> = What to do for 2.9 =
> 
> I propose to
> 
> * drop both "auth_supported" and "password-secret" from the QAPI schema
> 
> * drop "password-secret" from QemuOpts
> 
> * hide "keyvalue-pairs" in QemuOpts
> 
> No existing usage is affected, since all these things are new in 2.9.

Maybe I'm mis-understanding what you're suggesting wrt QemuOpts, but
'password-secret' with RBD is not new in 2.9.0

It was added in 2.6.0 in this commit:

commit 60390a2192e7b38aee18db6ce7fb740498709737
Author: Daniel P. Berrange <berrange@redhat.com>
Date:   Thu Jan 21 14:19:19 2016 +0000

    rbd: add support for getting password from QCryptoSecret object
    
    Currently RBD passwords must be provided on the command line
    via
    
      $QEMU -drive file=rbd:pool/image:id=myname:\
                   key=QVFDVm41aE82SHpGQWhBQXEwTkN2OGp0SmNJY0UrSE9CbE1RMUE=:\
                   auth_supported=cephx
    
    This is insecure because the key is visible in the OS process
    listing.
    
    This adds support for an 'password-secret' parameter in the RBD
    parameters that can be used with the QCryptoSecret object to
    provide the password via a file:
    
      echo "QVFDVm41aE82SHpGQWhBQXEwTkN2OGp0SmNJY0UrSE9CbE1RMUE=" > poolkey.b64
      $QEMU -object secret,id=secret0,file=poolkey.b64,format=base64 \
            -drive driver=rbd,filename=rbd:pool/image:id=myname:\
                   auth_supported=cephx,password-secret=secret0
    
    Reviewed-by: Josh Durgin <jdurgin@redhat.com>
    Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
    Message-id: 1453385961-10718-2-git-send-email-berrange@redhat.com
    Signed-off-by: Jeff Cody <jcody@redhat.com>

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|

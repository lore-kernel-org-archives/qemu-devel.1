Received: from eggs.gnu.org ([2001:4830:134:3::10]:51887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f6Xb2-0001KG-BH
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 04:28:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f6Xay-0005AR-EY
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 04:28:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52580 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1f6Xay-00059U-At
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 04:28:40 -0400
Date: Thu, 12 Apr 2018 09:28:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180412082822.GC31024@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1523089594-1422-1-git-send-email-lidongchen@tencent.com>
	<1523089594-1422-3-git-send-email-lidongchen@tencent.com>
	<20180411171818.GJ2667@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180411171818.GJ2667@work-vm>
Subject: Re: [Qemu-devel] [PATCH 2/5] migration: add the interface to set
 get_return_path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Lidong Chen <jemmy858585@gmail.com>, quintela@redhat.com, qemu-devel@nongnu.org, adido@mellanox.com, licq@mellanox.com, Lidong Chen <lidongchen@tencent.com>

On Wed, Apr 11, 2018 at 06:18:18PM +0100, Dr. David Alan Gilbert wrote:
> * Lidong Chen (jemmy858585@gmail.com) wrote:
> > The default get_return_path function of iochannel does not work for
> > RDMA live migration. So add the interface to set get_return_path.
> > 
> > Signed-off-by: Lidong Chen <lidongchen@tencent.com>
> 
> Lets see how Dan wants this done, he knows the channel/file stuff;
> to me this feels like it should be adding a member to QIOChannelClass
> that gets used by QEMUFile's get_return_path.

No that doesn't really fit the model. IMHO the entire concept of a separate
return path object is really wrong. The QIOChannel implementations are
(almost) all capable of bi-directional I/O, which is why the the get_retun_path
function just creates a second QEMUFile pointing to the same QIOChannel
object we already had. Migration only needs the second QEMUFile, because that
struct re-uses the same struct fields for tracking different bits of info
depending on which direction you're doing I/O in. A real fix would be to
stop overloading the same fields for multiple purposes in the QEMUFile, so
that we only needed a single QEMUFile instance.

Ignoring that though, the particular problem we're facing here is that the
QIOChannelRDMA impl that is used is not written in a way that allows
bi-directional I/O, despite the RDMA code it uses being capable of it.

So rather than changing this get_return_path code, IMHO, the right fix to
simply improve the QIOChannelRDMA impl so that it fully supports bi-directional
I/O like all the other channels do.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

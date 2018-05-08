Received: from eggs.gnu.org ([2001:4830:134:3::10]:45563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fG3wU-00051F-OM
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:50:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fG3wQ-000548-Nw
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:50:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39614 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fG3wQ-00053p-K6
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:50:10 -0400
References: <1520930033-18885-1-git-send-email-junyan.he@intel.com>
	<1520930033-18885-3-git-send-email-junyan.he@intel.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <433eb0d1-c6b2-ff49-26b6-664636cfe5b0@redhat.com>
Date: Tue, 8 May 2018 09:50:00 -0500
MIME-Version: 1.0
In-Reply-To: <1520930033-18885-3-git-send-email-junyan.he@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/10] RFC: Implement qcow2's snapshot
 dependent saving function.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: junyan.he@intel.com, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, crosthwaite.peter@gmail.com, quintela@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, rth@twiddle.net, Pavel Dovgaluk <Pavel.Dovgaluk@ispras.ru>

On 03/13/2018 03:33 AM, junyan.he@intel.com wrote:
> From: Junyan He <junyan.he@intel.com>
> 
> For qcow2 format, we can increase the cluster's reference count of
> dependent snapshot content and link the offset to the L2 table of
> the new snapshot point. This way can avoid obvious snapshot's dependent
> relationship, so when we delete some snapshot point, just decrease the
> cluster count and no need to check further.
> 
> Signed-off-by: Junyan He <junyan.he@intel.com>
> ---
>   block/qcow2-snapshot.c | 154 +++++++++++++++++++++++++++++++++++++++++++++++++
>   block/qcow2.c          |   2 +
>   block/qcow2.h          |   7 +++
>   3 files changed, 163 insertions(+)

It sounds like you are trying to modify the qcow2 spec to store more 
information into the internal snapshot table (and if you aren't, why 
not? If an internal snapshot depends on another one and we don't record 
that information in the qcow2 metadata, then we are pushing the burden 
of tracking inter-relationships onto management apps, and risk 
corruption if you load a snapshot without also visiting its 
dependencies).  It is absolutely essential that such modifications be 
reflected in docs/interop/qcow2.txt first, to make sure we agree on the 
implementation. What's more, there is already another parallel proposal 
that is also wanting to tweak qcow2 files:

https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg05231.html

We need to make sure both additions are coordinated.


> +
> +    if (!QEMU_IS_ALIGNED(depend_offset,  s->cluster_size)) {

Why two spaces here and elsewhere?


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

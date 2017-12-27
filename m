Received: from eggs.gnu.org ([2001:4830:134:3::10]:38392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eUC17-0007GA-Ll
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 08:45:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eUC14-0001pM-Tv
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 08:45:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54158)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eUC14-0001oX-NS
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 08:45:06 -0500
Date: Wed, 27 Dec 2017 14:44:43 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171227144443.42fb572c@igors-macbook-pro.local>
In-Reply-To: <20171218201340.27583-1-dgilbert@redhat.com>
References: <20171218201340.27583-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 0/7] Rework vhost memory region updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, maxime.coquelin@redhat.com, mst@redhat.com, groug@kaod.org

On Mon, 18 Dec 2017 20:13:33 +0000
"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Hi,
>   This patch set reworks the way the vhost code handles changes in
> physical address space layout that came from a discussion with Igor.
> 
> Its intention is to simplify a lot of the update code,
> and to make it easier for the postcopy+shared code to
> do the hugepage alignments that are needed.
> 
> Instead of inserting/removing each section during the add/del
> callbacks of the listener, we start afresh and build a list
> from the add and nop callbacks, then at the end compare the list
> we've built with the exisiting list.
> 
> v5
>   Solve the unref race found by Igor with a new 1st patch
>   Now we've got a temporary section list rework the rest of the set
>    around that.
> 
> Dr. David Alan Gilbert (7):
>   vhost: Build temporary section list and deref after commit
>   vhost: Move log_dirty check
>   vhost: Simplify ring verification checks
>   vhost: Merge sections added to temporary list
>   vhost: Regenerate region list from changed sections list
>   vhost: Clean out old vhost_set_memory and friends
>   vhost: Merge and delete unused callbacks
> 
>  hw/virtio/trace-events    |   6 +
>  hw/virtio/vhost.c         | 490 ++++++++++++++++------------------------------
>  include/hw/virtio/vhost.h |   5 +-
>  3 files changed, 174 insertions(+), 327 deletions(-)
Nice diffstat and more importantly it should be easier to reason about changes to memmap in future patches,
Thanks for making it easier to read/understand how memap updates work.

The series looks almost ready, I've Acked most of it modulo
    "vhost: Move log_dirty check"
      - I'm not convinced that doing it while old code still around is right thing to do as it might break bisectability,
        Maybe Michael may ack it if doesn't really affect old code,
        see discussion at '[PATCH v4 1/6] vhost: Move log_dirty check'

    "vhost: Regenerate region list from changed sections list"
      - suggested an additional cleanup

    "vhost: Clean out old vhost_set_memory and friends"
      - removes update to used_memslots without providing an alternative,
        it could lead to crashes when region count goes above backend's limit
        related thread "[PATCH v2 0/2] vhost: two fixes"

    the rest of comments are just minor issues

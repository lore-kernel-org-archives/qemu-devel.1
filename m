Received: from eggs.gnu.org ([2001:4830:134:3::10]:33594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dTBoY-0007SS-3K
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 14:47:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dTBoT-00040v-4q
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 14:47:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36632)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dTBoS-0003zs-UF
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 14:47:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D7554C04B946
	for <qemu-devel@nongnu.org>; Thu,  6 Jul 2017 18:47:39 +0000 (UTC)
Date: Thu, 6 Jul 2017 15:47:36 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170706184736.GB5167@localhost.localdomain>
References: <20170614203000.19984-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170614203000.19984-1-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/5] hostmem-file: Add "persistent" option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On Wed, Jun 14, 2017 at 05:29:55PM -0300, Eduardo Habkost wrote:
> This series adds a new "persistent" option to
> memory-backend-file.  The new option it will be useful if
> somebody is sharing RAM contents on a file using share=on, but
> don't need it to be flushed to disk when QEMU exits.
> 
> Internally, it will trigger a madvise(MADV_REMOVE) or
> fallocate(FALLOC_FL_PUNCH_HOLE) call when the memory backend is
> destroyed.
> 
> To make we actually trigger the new code when QEMU exits, the
> first patch in the series ensures we destroy all user-created
> objects when exiting QEMU.

In addition to the additional fixes I have planned for v2, it
looks like this series won't be enough: the memory regions will
still have a non-zero reference count when exiting QEMU.  I'm not
sure how much extra work will be required to fix that.

-- 
Eduardo

Received: from eggs.gnu.org ([2001:4830:134:3::10]:46445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dgCrz-0006pl-Lw
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 12:33:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dgCrw-0005Gb-Js
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 12:33:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36630)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dgCrw-0005G5-EZ
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 12:33:04 -0400
Date: Fri, 11 Aug 2017 13:33:00 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170811163300.GA29509@localhost.localdomain>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Zack Cornelius <zack.cornelius@kove.net>

CCing Zack Cornelius.

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

So, before sending a new version of this, we need to clarify one
thing: why exactly unlink()+close() wouldn't be enough to avoid
having data unnecessarily flushed to the backing store and make
the new option unnecessary?

I would expect close() to not write any data unnecessarily if
there are no remaining references to the file.  Why/when this is
not the case?

-- 
Eduardo

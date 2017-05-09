Received: from eggs.gnu.org ([2001:4830:134:3::10]:34884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d81Yl-0004wK-O2
	for qemu-devel@nongnu.org; Tue, 09 May 2017 05:36:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d81Yg-0004oC-Q9
	for qemu-devel@nongnu.org; Tue, 09 May 2017 05:35:59 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  9 May 2017 11:35:45 +0200
Message-Id: <20170509093549.25157-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] curl: locking cleanups and fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, jcody@redhat.com, rjones@redhat.com

This is the full version of the simple patch:

@@ -473,7 +475,9 @@
             break;
         }
         if (!state) {
+            qemu_mutex_unlock(&s->mutex);
             aio_poll(bdrv_get_aio_context(bs), true);
+            qemu_mutex_lock(&s->mutex);
         }
     } while(!state);

that was tested by Richard last week.  Richard, please retest with your test
case.

Thanks,

Paolo

Paolo Bonzini (4):
  curl: strengthen assertion in curl_clean_state
  curl: never invoke callbacks with s->mutex held
  curl: avoid recursive locking of BDRVCURLState mutex
  curl: improve search for unused CURLState

 block/curl.c | 78 ++++++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 55 insertions(+), 23 deletions(-)

-- 
2.12.2

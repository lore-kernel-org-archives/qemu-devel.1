Received: from eggs.gnu.org ([2001:4830:134:3::10]:56214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d8Sf0-00015B-Qh
	for qemu-devel@nongnu.org; Wed, 10 May 2017 10:32:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d8Sf0-00028M-1Y
	for qemu-devel@nongnu.org; Wed, 10 May 2017 10:32:14 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 10 May 2017 16:31:58 +0200
Message-Id: <20170510143205.32013-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/7] curl: locking cleanups/fixes,
 coroutine conversion, remove aio_poll
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jcody@redhat.com, qemu-stable@nongnu.org, qemu-block@nongnu.org, rjones@redhat.com

Since the last patch in v1 didn't work, I bit the bullet and converted
the whole thing to coroutines (patches 4-6).  This in turns allows a more
elegant solution to wait for CURLStates to get free (patch 7).

I tested this by lowering CURL_NUM_STATES to 2.  With this change, the
buggy case triggers a couple times while booting a Fedora netinst image.

Paolo

Paolo Bonzini (7):
  curl: strengthen assertion in curl_clean_state
  curl: never invoke callbacks with s->mutex held
  curl: avoid recursive locking of BDRVCURLState mutex
  curl: split curl_find_state/curl_init_state
  curl: convert CURLAIOCB to byte values
  curl: convert readv to coroutines
  curl: do not do aio_poll when waiting for a free CURLState

 block/curl.c              | 216 +++++++++++++++++++++++++---------------------
 1 files changed, 120 insertions(+), 96 deletions(-)

-- 
2.12.2

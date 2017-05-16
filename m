Received: from eggs.gnu.org ([2001:4830:134:3::10]:52736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dAaRV-00036G-91
	for qemu-devel@nongnu.org; Tue, 16 May 2017 07:15:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dAaRS-00056Y-Kk
	for qemu-devel@nongnu.org; Tue, 16 May 2017 07:15:05 -0400
References: <20170516094533.6160-1-vsementsov@virtuozzo.com>
	<f2465a29-a1d2-24de-b765-fe1106640144@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <5eb45a78-c0f0-c24b-ef58-c21289926270@virtuozzo.com>
Date: Tue, 16 May 2017 14:15:00 +0300
MIME-Version: 1.0
In-Reply-To: <f2465a29-a1d2-24de-b765-fe1106640144@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/5] nbd: error path refactoring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

16.05.2017 13:00, Paolo Bonzini wrote:
>
> On 16/05/2017 11:45, Vladimir Sementsov-Ogievskiy wrote:
>> Hi all. There are several patches, as preparation for v2 of my
>> NBD BLOCK_STATUS series.
>>
>> patch 0001 was sent earlier and unchanged here.
> Thanks, applied.  I suppose that if we can remove
> nbd_negotiate_read/write/drop it's also easy to change from LOG to
> error_report_err in nbd/server.c.

Thank you and sorry for build error =(. I've sent updated last patch - 
"[PATCH v2] nbd/client.c: use errp instead of LOG", with following 
changes amended:

diff --git a/nbd/client.c b/nbd/client.c
index e41b4fd935..f9e1d75be4 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -725,8 +725,10 @@ int nbd_disconnect(int fd)
  }

  #else
-int nbd_init(int fd, QIOChannelSocket *ioc, uint16_t flags, off_t size)
+int nbd_init(int fd, QIOChannelSocket *ioc, uint16_t flags, off_t size,
+             Error **errp)
  {
+    error_setg(errp, "nbd_init is not supported");
      return -ENOTSUP;
  }




>
> Paolo
>
>> Vladimir Sementsov-Ogievskiy (5):
>>    nbd: strict nbd_wr_syncv
>>    nbd: read_sync and friends: return 0 on success
>>    nbd: add errp parameter to nbd_wr_syncv()
>>    nbd: add errp to read_sync, write_sync and drop_sync
>>    nbd/client.c: use errp instead of LOG
>>
>>   block/nbd-client.c  |  11 +++--
>>   include/block/nbd.h |   8 ++--
>>   nbd/client.c        | 121 ++++++++++++++++++++++++----------------------------
>>   nbd/common.c        |  23 +++++-----
>>   nbd/nbd-internal.h  |  40 ++++++++++++++---
>>   nbd/server.c        |  92 ++++++++++++++++-----------------------
>>   qemu-nbd.c          |   3 +-
>>   7 files changed, 153 insertions(+), 145 deletions(-)
>>


-- 
Best regards,
Vladimir

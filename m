Received: from eggs.gnu.org ([2001:4830:134:3::10]:43277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dimastep@yandex-team.ru>) id 1fTkly-000320-MN
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 05:11:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dimastep@yandex-team.ru>) id 1fTklt-0002X7-Se
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 05:11:58 -0400
Received: from forwardcorp1o.cmail.yandex.net ([37.9.109.47]:35800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dimastep@yandex-team.ru>)
	id 1fTklt-0002US-FG
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 05:11:53 -0400
From: Dima Stepanov <dimastep@yandex-team.ru>
Date: Fri, 15 Jun 2018 12:11:44 +0300
Message-Id: <1529053904-12607-1-git-send-email-dimastep@yandex-team.ru>
Subject: [Qemu-devel] [PATCH v1] qemu-pr-helper: garbage response structure
 can be used to write data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: wrfsh@yandex-team.ru

The prh_co_entry() routine handles requests. The first part is to read a
request by calling the prh_read_request() routine, if:
  1. scsi_cdb_xfer(req->cdb) call returns 0, and
  2. req->cdb[0] == PERSISTENT_RESERVE_IN, then
The resp->result field will be uninitialized. As a result the resp.sz
field will be also uninitialized in the prh_co_entry() function.
The second part is to send the response by calling the
prh_write_response() routine:
  1. For the PERSISTENT_RESERVE_IN command, and
  2. resp->result == GOOD (previous successful reply or just luck), then
There is a probability that the following assert will not be trigered:
  assert(resp->sz <= req->sz && resp->sz <= sizeof(client->data));
As a result some uninitialized response will be sent.

The fix is to initialize the response structure to CHECK_CONDITION and 0
values before calling the prh_read_request() routine.

Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
---
 scsi/qemu-pr-helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index d0f8317..85878c2 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -768,6 +768,8 @@ static void coroutine_fn prh_co_entry(void *opaque)
         PRHelperResponse resp;
         int sz;
 
+        resp.result = CHECK_CONDITION;
+        resp.sz = 0;
         sz = prh_read_request(client, &req, &resp, &local_err);
         if (sz < 0) {
             break;
-- 
2.7.4

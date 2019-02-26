Received: from eggs.gnu.org ([209.51.188.92]:40357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1gycaL-0005CM-4l
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 08:15:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1gycaI-0006ug-UY
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 08:15:49 -0500
Received: from relay.sw.ru ([185.231.240.75]:43586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
	id 1gycaI-0006tJ-DA
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 08:15:46 -0500
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Date: Tue, 26 Feb 2019 16:15:32 +0300
Message-Id: <20190226131535.30361-1-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/3] migration: add sztd compression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com, quintela@redhat.com, eblake@redhat.com, armbru@redhat.com
Cc: den@virtuozzo.com, qemu-devel@nongnu.org

zstd date compression algorithm shows better performance on data compression.
It might be useful to employ the algorithm in VM migration to reduce CPU usage.
A user will be able to choose between those algorithms, therefor compress-type
migration parameter is added.

Here are some results of performance comparison zstd vs gzip:

host: i7-4790 8xCPU @ 3.60GHz, 16G RAM
migration to the same host
VM: 2xVCPU, 8G RAM total
5G RAM used, memory populated with postgreqsl data
produced by pgbench performance benchmark


Threads: 1 compress – 1 decompress

zstd provides slightly less compression ratio with almost the same
CPU usage but copes with RAM  compression roghly 2 times faster

compression type              zlib       |      zstd
---------------------------------------------------------
compression level          1       5     |   1       5
compression ratio          6.92    7.05  |   6.69    6.89
cpu idle, %                82      83    |   86      80
time, sec                  49      71    |   26      31
time diff to zlib, sec                      -25     -41


Threads: 8 compress – 2 decompress

zstd provides the same migration time with less cpu consumption

compression type         none  |        gzip(zlib)    |          zstd
------------------------------------------------------------------------------
compression level        -     |  1      5       9    |   1       5       15
compression ratio        -     |  6.94   6.99    7.14 |   6.64    6.89    6.93
time, sec                154   |  22     23      27   |   23      23      25
cpu idle, %              99    |  45     30      12   |   70      52      23
cpu idle diff to zlib          |                      |  -25%    -22%    -11%


Denis Plotnikov (3):
  migration: rework compression code for adding more data compressors
  hmp: add compress-type parameter to migration parameters
  migration: add zstd compression

 configure             |  26 ++++
 hmp.c                 |   8 ++
 migration/migration.c |  45 ++++++-
 migration/migration.h |   1 +
 migration/qemu-file.c |  39 ++----
 migration/qemu-file.h |  18 ++-
 migration/ram.c       | 291 ++++++++++++++++++++++++++++++++++--------
 qapi/migration.json   |  26 +++-
 8 files changed, 369 insertions(+), 85 deletions(-)

-- 
2.17.0

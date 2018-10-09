Received: from eggs.gnu.org ([2001:4830:134:3::10]:37378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g9sYL-0006pA-5x
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:00:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g9sYK-0008Q3-9W
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:00:01 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:41415)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1g9sYK-0008Ok-0C
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:00:00 -0400
Received: by mail-wr1-x42c.google.com with SMTP id x12-v6so1945307wru.8
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 06:59:59 -0700 (PDT)
MIME-Version: 1.0
References: <20181009125541.24455-1-berrange@redhat.com>
In-Reply-To: <20181009125541.24455-1-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 9 Oct 2018 17:59:46 +0400
Message-ID: <CAJ+F1CKAZU+aHuzO8Y-aT20uX-rywZB3BK0=1hqecSrPkUEp1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/6] crypto: improve performance of XTS
 cipher mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Alberto Garcia <berto@igalia.com>

Hi

On Tue, Oct 9, 2018 at 4:57 PM Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
>
> The XTS cipher mode is significantly slower than CBC mode. This series
> approximately doubles the XTS performance which will improve the I/O
> rate for LUKS disks.
>
> Daniel P. Berrang=C3=A9 (6):
>   crypto: expand algorithm coverage for cipher benchmark
>   crypto: remove code duplication in tweak encrypt/decrypt
>   crypto: introduce a xts_uint128 data type
>   crypto: convert xts_tweak_encdec to use xts_uint128 type
>   crypto: convert xts_mult_x to use xts_uint128 type
>   crypto: annotate xts_tweak_encdec as inlineable
>
>  crypto/xts.c                    | 147 ++++++++++++++-----------------
>  tests/benchmark-crypto-cipher.c | 149 +++++++++++++++++++++++++++-----
>  2 files changed, 191 insertions(+), 105 deletions(-)

By using a constant amount of data to process, it's easier to measure
perfomance with perf stat:

diff --git a/tests/benchmark-crypto-cipher.c b/tests/benchmark-crypto-ciphe=
r.c
index a8325a9510..32a19987e6 100644
--- a/tests/benchmark-crypto-cipher.c
+++ b/tests/benchmark-crypto-cipher.c
@@ -65,7 +65,7 @@ static void test_cipher_speed(size_t chunk_size,
                                         chunk_size,
                                         &err) =3D=3D 0);
         total +=3D chunk_size;
-    } while (g_test_timer_elapsed() < 1.0);
+    } while (total / MiB < 500);

     total /=3D MiB;
     g_print("Enc chunk %zu bytes ", chunk_size);
@@ -80,7 +80,7 @@ static void test_cipher_speed(size_t chunk_size,
                                         chunk_size,
                                         &err) =3D=3D 0);
         total +=3D chunk_size;
-    } while (g_test_timer_elapsed() < 1.0);
+    } while (total / MiB < 500);

On my laptop: before your series:
       3701.625051      task-clock:u (msec)       #    0.997 CPUs
utilized
                 0      context-switches:u        #    0.000 K/sec
                 0      cpu-migrations:u          #    0.000 K/sec
               438      page-faults:u             #    0.118 K/sec
    10,823,305,761      cycles:u                  #    2.924 GHz
    29,774,419,538      instructions:u            #    2.75  insn per
cycle
     4,919,267,782      branches:u                # 1328.948 M/sec
        32,923,105      branch-misses:u           #    0.67% of all
branches

       3.712998264 seconds time elapsed

Ater:
       2151.201355      task-clock:u (msec)       #    1.000 CPUs
utilized
                 0      context-switches:u        #    0.000 K/sec
                 0      cpu-migrations:u          #    0.000 K/sec
               431      page-faults:u             #    0.200 K/sec
     7,073,869,618      cycles:u                  #    3.288 GHz
     8,573,595,534      instructions:u            #    1.21  insn per
cycle
     1,576,926,668      branches:u                #  733.045 M/sec
           148,987      branch-misses:u           #    0.01% of all
branches

       2.151520872 seconds time elapsed


--=20
Marc-Andr=C3=A9 Lureau

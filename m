Received: from eggs.gnu.org ([2001:4830:134:3::10]:58961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dW0Gw-0004cu-EU
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:04:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dW0Gs-0007sb-KM
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:04:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43082)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dW0Gs-0007rY-BB
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:04:38 -0400
Date: Fri, 14 Jul 2017 14:04:28 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170714130428.GG28095@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1500032321-13951-1-git-send-email-longpeng.mike@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1500032321-13951-1-git-send-email-longpeng.mike@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v5 00/18] crypto: add afalg-backend support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: longpeng.mike@gmail.com
Cc: qemu-devel@nongnu.org, arei.gonglei@huawei.com, weidong.huang@huawei.com, "Longpeng(Mike)" <longpeng2@huawei.com>

On Fri, Jul 14, 2017 at 07:38:22AM -0400, longpeng.mike@gmail.com wrote:
> From: "Longpeng(Mike)" <longpeng2@huawei.com>
> 
> The AF_ALG socket family is the userspace interface for linux
> crypto API, users can use it to access hardware accelerators.
> 
> This patchset adds a afalg-backend for qemu crypto subsystem. Currently
> when performs encrypt/decrypt, we'll try afalg-backend first and will
> back to libiary-backend if it failed.
> 
> In the next step, It would support a command parameter to specifies
> which backends prefer to and some other improvements.
> 
> I measured the performance about the afalg-backend impls, I tested
> how many data could be encrypted in 5 seconds.
> 
> NOTE: If we use specific hardware crypto cards, I think afalg-backend
>       would even faster.
> 
> test-environment: Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz
> 
> *sha256*
> chunk_size(bytes)   MB/sec(afalg:sha256-ssse3)  MB/sec(nettle)
> 512                 93.03                       185.87
> 1024                146.32                      201.78
> 2048                213.32                      210.93
> 4096                275.48                      215.26
> 8192                321.77                      217.49
> 16384               349.60                      219.26
> 32768               363.59                      219.73
> 65536               375.79                      219.99
> 
> *hmac(sha256)*
> chunk_size(bytes)   MB/sec(afalg:sha256-ssse3)  MB/sec(nettle)
> 512                 71.26                       165.55
> 1024                117.43                      189.15
> 2048                180.96                      203.24
> 4096                247.60                      211.38
> 8192                301.99                      215.65
> 16384               340.79                      218.22
> 32768               365.51                      219.49
> 65536               377.92                      220.24
> 
> *cbc(aes128)*
> chunk_size(bytes)   MB/sec(afalg:cbc-aes-aesni)  MB/sec(nettle)
> 512                 371.76                       188.41
> 1024                559.86                       189.64
> 2048                768.66                       192.11
> 4096                939.15                       192.40
> 8192                1029.48                      192.49
> 16384               1072.79                      190.52
> 32768               1109.38                      190.41
> 65536               1102.38                      190.40

So I've attempted to replicate these results, and see totally
different outcome. NB, I hacked your code so that setting
QEMU_DISABLE_AF_ALG=1 would skip the af-alg impl. The results
I get are:

$ tests/benchmark-crypto-hash --quiet
sha256: Testing chunk_size 512 bytes done: 197.31 MB in 5.00 secs: 39.46 MB/sec
sha256: Testing chunk_size 1024 bytes done: 337.03 MB in 5.00 secs: 67.41 MB/sec
sha256: Testing chunk_size 2048 bytes done: 516.27 MB in 5.00 secs: 103.25 MB/sec
sha256: Testing chunk_size 4096 bytes done: 675.18 MB in 5.00 secs: 135.04 MB/sec
sha256: Testing chunk_size 8192 bytes done: 837.73 MB in 5.00 secs: 167.55 MB/sec
sha256: Testing chunk_size 16384 bytes done: 946.78 MB in 5.00 secs: 189.35 MB/sec
sha256: Testing chunk_size 32768 bytes done: 1008.56 MB in 5.00 secs: 201.71 MB/sec
sha256: Testing chunk_size 65536 bytes done: 1037.19 MB in 5.00 secs: 207.43 MB/sec

$ QEMU_DISABLE_AF_ALG=1 tests/benchmark-crypto-hash --quiet
sha256: Testing chunk_size 512 bytes done: 1099.92 MB in 5.00 secs: 219.98 MB/sec
sha256: Testing chunk_size 1024 bytes done: 1223.40 MB in 5.00 secs: 244.68 MB/sec
sha256: Testing chunk_size 2048 bytes done: 1304.04 MB in 5.00 secs: 260.81 MB/sec
sha256: Testing chunk_size 4096 bytes done: 1339.29 MB in 5.00 secs: 267.86 MB/sec
sha256: Testing chunk_size 8192 bytes done: 1359.68 MB in 5.00 secs: 271.94 MB/sec
sha256: Testing chunk_size 16384 bytes done: 1363.58 MB in 5.00 secs: 272.71 MB/sec
sha256: Testing chunk_size 32768 bytes done: 1364.66 MB in 5.00 secs: 272.93 MB/sec
sha256: Testing chunk_size 65536 bytes done: 1326.56 MB in 5.00 secs: 265.30 MB/sec


  ==> AF_ALG is slower in every case, by as much as x4



$ tests/benchmark-crypto-hmac --quiet
hmac(sha256): Testing chunk_size 512 bytes done: 173.83 MB in 5.00 secs: 34.77 MB/sec
hmac(sha256): Testing chunk_size 1024 bytes done: 302.32 MB in 5.00 secs: 60.46 MB/sec
hmac(sha256): Testing chunk_size 2048 bytes done: 469.93 MB in 5.00 secs: 93.99 MB/sec
hmac(sha256): Testing chunk_size 4096 bytes done: 648.27 MB in 5.00 secs: 129.65 MB/sec
hmac(sha256): Testing chunk_size 8192 bytes done: 800.80 MB in 5.00 secs: 160.16 MB/sec
hmac(sha256): Testing chunk_size 16384 bytes done: 887.09 MB in 5.00 secs: 177.42 MB/sec
hmac(sha256): Testing chunk_size 32768 bytes done: 932.09 MB in 5.00 secs: 186.41 MB/sec
hmac(sha256): Testing chunk_size 65536 bytes done: 1013.25 MB in 5.00 secs: 202.64 MB/sec

$ QEMU_DISABLE_AF_ALG=1 tests/benchmark-crypto-hmac --quiet
hmac(sha256): Testing chunk_size 512 bytes done: 751.36 MB in 5.00 secs: 150.27 MB/sec
hmac(sha256): Testing chunk_size 1024 bytes done: 961.43 MB in 5.00 secs: 192.29 MB/sec
hmac(sha256): Testing chunk_size 2048 bytes done: 1110.92 MB in 5.00 secs: 222.18 MB/sec
hmac(sha256): Testing chunk_size 4096 bytes done: 1225.78 MB in 5.00 secs: 245.16 MB/sec
hmac(sha256): Testing chunk_size 8192 bytes done: 1300.52 MB in 5.00 secs: 260.10 MB/sec
hmac(sha256): Testing chunk_size 16384 bytes done: 1327.00 MB in 5.00 secs: 265.40 MB/sec
hmac(sha256): Testing chunk_size 32768 bytes done: 1345.72 MB in 5.00 secs: 269.14 MB/sec
hmac(sha256): Testing chunk_size 65536 bytes done: 1348.50 MB in 5.00 secs: 269.69 MB/sec


  ==> AF_ALG is slower in every case, by as much as x4



$ tests/benchmark-crypto-cipher --quiet
cbc(aes128): Testing chunk_size 512 bytes done: 1571.74 MB in 5.00 secs: 314.35 MB/sec
cbc(aes128): Testing chunk_size 1024 bytes done: 2436.54 MB in 5.00 secs: 487.31 MB/sec
cbc(aes128): Testing chunk_size 2048 bytes done: 3412.53 MB in 5.00 secs: 682.50 MB/sec
cbc(aes128): Testing chunk_size 4096 bytes done: 4307.00 MB in 5.00 secs: 861.40 MB/sec
cbc(aes128): Testing chunk_size 8192 bytes done: 4854.20 MB in 5.00 secs: 970.84 MB/sec
cbc(aes128): Testing chunk_size 16384 bytes done: 5180.72 MB in 5.00 secs: 1036.14 MB/sec
cbc(aes128): Testing chunk_size 32768 bytes done: 5390.25 MB in 5.00 secs: 1078.05 MB/sec
cbc(aes128): Testing chunk_size 65536 bytes done: 5427.94 MB in 5.00 secs: 1085.59 MB/sec


$ QEMU_DISABLE_AF_ALG=1 tests/benchmark-crypto-cipher --quiet
cbc(aes128): Testing chunk_size 512 bytes done: 4204.65 MB in 5.00 secs: 840.93 MB/sec
cbc(aes128): Testing chunk_size 1024 bytes done: 4362.01 MB in 5.00 secs: 872.40 MB/sec
cbc(aes128): Testing chunk_size 2048 bytes done: 4347.91 MB in 5.00 secs: 869.58 MB/sec
cbc(aes128): Testing chunk_size 4096 bytes done: 4432.54 MB in 5.00 secs: 886.51 MB/sec
cbc(aes128): Testing chunk_size 8192 bytes done: 4416.47 MB in 5.00 secs: 883.29 MB/sec
cbc(aes128): Testing chunk_size 16384 bytes done: 4469.45 MB in 5.00 secs: 893.89 MB/sec
cbc(aes128): Testing chunk_size 32768 bytes done: 4454.56 MB in 5.00 secs: 890.91 MB/sec
cbc(aes128): Testing chunk_size 65536 bytes done: 4518.50 MB in 5.00 secs: 903.70 MB/sec


  => AF_ALG is slower until chunk_size is 8192 or larger.


I of course don't have the same CPU as you, but it is a representative
current model  Intel(R) Core(TM) i7-6820HQ CPU @ 2.70GHz

I can, however, imagine that there are scenarios where this is faster,
particularly if using this in an embedded scenario with a relatively
low perf main CPU, but a hardware accelerator available.

Based on this though, I'm very reluctant to enable AF_ALG by default
when building QEMU, because I think it'll likely cause a major perf
regression for the common case of people with fast CPUs and no
hardware accelerator.

I think in the immediate term we should add a switch to configure
--enable-crypto-afalg, that must be opt-in when building QEMU,
so those people who know they have good hardware accelerator
present can use it, but in the general case we avoid it.

For the general case, I think we need to figure out how to make
direct use of CPU insturctions for crypto, eg Intel aesni. This
might be possible by using GNUTLS for ciphers (though it lacks
coverage for all the combinations we want)

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

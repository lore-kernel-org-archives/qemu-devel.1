Received: from eggs.gnu.org ([2001:4830:134:3::10]:56567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng.mike@gmail.com>) id 1dW3hz-0006Gy-DU
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 12:44:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng.mike@gmail.com>) id 1dW3hy-0007wb-7X
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 12:44:51 -0400
Received: from mail-oi0-x230.google.com ([2607:f8b0:4003:c06::230]:35365)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <longpeng.mike@gmail.com>)
	id 1dW3hy-0007wL-0r
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 12:44:50 -0400
Received: by mail-oi0-x230.google.com with SMTP id 191so75658707oii.2
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 09:44:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170714130428.GG28095@redhat.com>
References: <1500032321-13951-1-git-send-email-longpeng.mike@gmail.com>
	<20170714130428.GG28095@redhat.com>
From: "Longpeng(Mike)" <longpeng.mike@gmail.com>
Date: Sat, 15 Jul 2017 00:44:48 +0800
Message-ID: <CACnE9pwe-3wg7DvNmRBxzf8+7VrEqtZf-uxNPAB0Rhr8UtP4DQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 00/18] crypto: add afalg-backend support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, arei.gonglei@huawei.com, weidong.huang@huawei.com, "Longpeng(Mike)" <longpeng2@huawei.com>

2017-07-14 21:04 GMT+08:00 Daniel P. Berrange <berrange@redhat.com>:
> On Fri, Jul 14, 2017 at 07:38:22AM -0400, longpeng.mike@gmail.com wrote:
>> From: "Longpeng(Mike)" <longpeng2@huawei.com>
>>
[...]

>>
>> NOTE: If we use specific hardware crypto cards, I think afalg-backend
>>       would even faster.
>>
>> test-environment: Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz
>>
>> *sha256*
>> chunk_size(bytes)   MB/sec(afalg:sha256-ssse3)  MB/sec(nettle)
>> 512                 93.03                       185.87
>> 1024                146.32                      201.78
>> 2048                213.32                      210.93
>> 4096                275.48                      215.26
>> 8192                321.77                      217.49
>> 16384               349.60                      219.26
>> 32768               363.59                      219.73
>> 65536               375.79                      219.99
>>
>> *hmac(sha256)*
>> chunk_size(bytes)   MB/sec(afalg:sha256-ssse3)  MB/sec(nettle)
>> 512                 71.26                       165.55
>> 1024                117.43                      189.15
>> 2048                180.96                      203.24
>> 4096                247.60                      211.38
>> 8192                301.99                      215.65
>> 16384               340.79                      218.22
>> 32768               365.51                      219.49
>> 65536               377.92                      220.24
>>
>> *cbc(aes128)*
>> chunk_size(bytes)   MB/sec(afalg:cbc-aes-aesni)  MB/sec(nettle)
>> 512                 371.76                       188.41
>> 1024                559.86                       189.64
>> 2048                768.66                       192.11
>> 4096                939.15                       192.40
>> 8192                1029.48                      192.49
>> 16384               1072.79                      190.52
>> 32768               1109.38                      190.41
>> 65536               1102.38                      190.40
>
> So I've attempted to replicate these results, and see totally
> different outcome. NB, I hacked your code so that setting
> QEMU_DISABLE_AF_ALG=1 would skip the af-alg impl. The results
> I get are:
>
> $ tests/benchmark-crypto-hash --quiet
> sha256: Testing chunk_size 512 bytes done: 197.31 MB in 5.00 secs: 39.46 MB/sec
> sha256: Testing chunk_size 1024 bytes done: 337.03 MB in 5.00 secs: 67.41 MB/sec
> sha256: Testing chunk_size 2048 bytes done: 516.27 MB in 5.00 secs: 103.25 MB/sec
> sha256: Testing chunk_size 4096 bytes done: 675.18 MB in 5.00 secs: 135.04 MB/sec
> sha256: Testing chunk_size 8192 bytes done: 837.73 MB in 5.00 secs: 167.55 MB/sec
> sha256: Testing chunk_size 16384 bytes done: 946.78 MB in 5.00 secs: 189.35 MB/sec
> sha256: Testing chunk_size 32768 bytes done: 1008.56 MB in 5.00 secs: 201.71 MB/sec
> sha256: Testing chunk_size 65536 bytes done: 1037.19 MB in 5.00 secs: 207.43 MB/sec
[...]

>
> I of course don't have the same CPU as you, but it is a representative
> current model  Intel(R) Core(TM) i7-6820HQ CPU @ 2.70GHz
>
> I can, however, imagine that there are scenarios where this is faster,
> particularly if using this in an embedded scenario with a relatively
> low perf main CPU, but a hardware accelerator available.
>
> Based on this though, I'm very reluctant to enable AF_ALG by default
> when building QEMU, because I think it'll likely cause a major perf
> regression for the common case of people with fast CPUs and no
> hardware accelerator.
>
> I think in the immediate term we should add a switch to configure
> --enable-crypto-afalg, that must be opt-in when building QEMU,
> so those people who know they have good hardware accelerator
> present can use it, but in the general case we avoid it.
>

OK.

We can take this measure currently.

But some hardware accelerators only support limit amount of algos,
maybe in the next step we need a cmdline param to specify which
algo uses afalg- backend and other algos still use library-backend
even though we '--enale-crypto-afalg'.

Anyway, I'll modify the code as your suggestion first.  :)


> For the general case, I think we need to figure out how to make
> direct use of CPU insturctions for crypto, eg Intel aesni. This
> might be possible by using GNUTLS for ciphers (though it lacks
> coverage for all the combinations we want)
>

IIUC,  newer gcrypt/nettle would use CPU insturctions for crypto if
CPU support.

-- 
Regards,
Longpeng

> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

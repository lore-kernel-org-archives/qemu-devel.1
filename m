Received: from eggs.gnu.org ([2001:4830:134:3::10]:44656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXc9D-0007JN-0d
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 19:43:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXc99-0005YT-Tt
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 19:43:23 -0400
Received: from mail-qk0-x231.google.com ([2607:f8b0:400d:c09::231]:36322)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXc99-0005YD-OZ
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 19:43:19 -0400
Received: by mail-qk0-x231.google.com with SMTP id d136so29791702qkg.3
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 16:43:19 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
	<1500235468-15341-11-git-send-email-cota@braap.org>
	<92056605-c95b-b19b-0216-5d83be64e13d@twiddle.net>
	<20170718002700.GA7414@flamenco>
	<5382470b-120c-1cdd-32f3-d246d75059d2@twiddle.net>
	<20170718045458.GB12960@flamenco>
	<b0eb3da8-14a3-fae2-b4c9-72696fece97b@twiddle.net>
	<20170718233035.GA10731@flamenco>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <2dc5a435-700b-4a79-4c16-96c0f94d34fb@twiddle.net>
Date: Tue, 18 Jul 2017 13:43:13 -1000
MIME-Version: 1.0
In-Reply-To: <20170718233035.GA10731@flamenco>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 10/45] translate-all: guarantee that
 tb_hash only holds valid TBs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org

On 07/18/2017 01:30 PM, Emilio G. Cota wrote:
> Should I do those updates in the same patch where tb->invalid is brought
> over to cflags? Alternatives: have a later patch where all readers
> are converted to atomic_read, or keep tb->invalid as a separate field (we
> could use that 4-byte hole in struct tb_tc..)

I would prefer the readers be converted in a separate patch.
I wonder if an accessor inline might be in order?

static inline uint32_t tb_cflags(TranslationBlock *tb)
{
     return atomic_read(tb->cflags);
}

That might keep line lengths from expanding too much...

Please don't try to do anything clever to re-use padding holes.
I think that's just confusing and probably premature optimization.


r~

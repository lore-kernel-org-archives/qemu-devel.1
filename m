Received: from eggs.gnu.org ([2001:4830:134:3::10]:50624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1d0X9k-0007a4-VV
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 13:43:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1d0X9j-0005R8-OH
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 13:43:13 -0400
Received: from mail-oi0-x230.google.com ([2607:f8b0:4003:c06::230]:33543)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashijeetacharya@gmail.com>)
	id 1d0X9j-0005Qt-JC
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 13:43:11 -0400
Received: by mail-oi0-x230.google.com with SMTP id b187so169854oif.0
	for <qemu-devel@nongnu.org>; Tue, 18 Apr 2017 10:43:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <b45474c4-e4f6-6509-adcd-31aee92fd62c@redhat.com>
References: <CAC2QTZa6LW2LcWQUDvT88KVw=O+D99ku03XcE3kiLi_SC4UMBw@mail.gmail.com>
	<4ea264eb-128c-569a-264c-8ffa3956dca2@redhat.com>
	<CAC2QTZYq4v+zcYQ3LrkWrYdZYEVwYe1kjpfh30+kKe+p+Z3-vg@mail.gmail.com>
	<b45474c4-e4f6-6509-adcd-31aee92fd62c@redhat.com>
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Tue, 18 Apr 2017 23:13:10 +0530
Message-ID: <CAC2QTZbvyKNFjLhaDn_tWzeF=X2kkNpq=2wws_yBLkhFbiBJBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] DMG chunk size independence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, Apr 18, 2017 at 10:35 PM, John Snow <jsnow@redhat.com> wrote:
>
>>
>>     I could be wrong, but that's my hunch.
>>
>>     Maybe you can cache the state of the INFLATE process such that once you
>>     fill the cache with data, we can simply resume the INFLATE procedure
>>     when the guest almost inevitably asks for the next subsequent bytes.
>>
>>     That'd probably be efficient /enough/ in most cases without having to
>>     worry about a metadata cache for zlib blocks or a literal data cache for
>>     inflated data.
>>
>>
>> Yes, I have a similar approach in mind to inflate one sector at a time
>> and save the offset in the compressed stream and treat it as an access
>> point for the next one.
>>
>
> Right, just save whatever zlib library state you need to save and resume
> inflating. Probably the most reasonable way to go for v1. As long as you
> can avoid re-inflating prior data in a chunk when possible this is
> probably good.

Yup, I have started with that. Something you should know is that I had
an IRC discussion with Kevin and he suggested to fix the buffer size
to a max of 2MiB as 512b (which I proposed in my previous response) is
excessively low and will slow down the driver drastically!

Ashijeet

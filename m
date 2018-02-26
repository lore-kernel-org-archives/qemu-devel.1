Received: from eggs.gnu.org ([2001:4830:134:3::10]:38517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eqJ5h-0000ih-PV
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 08:45:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eqJ5c-0005Lx-14
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 08:45:17 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <05a3cab8-d5a0-e63f-3ba5-3b29e6e19e9e@redhat.com>
References: <20180223125047.343-1-berto@igalia.com>
	<05a3cab8-d5a0-e63f-3ba5-3b29e6e19e9e@redhat.com>
Date: Mon, 26 Feb 2018 14:44:33 +0100
Message-ID: <w51h8q3dfwe.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] iotests: Test abnormally large size in
 compressed cluster descriptor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Fri 23 Feb 2018 02:30:14 PM CET, Eric Blake wrote:
>> One possible task for the future is to make 'qemu-img check' verify
>> the sizes of the compressed clusters, by trying to decompress the data
>> and checking that the size stored in the L2 entry is correct.
>
> Indeed, but that means...
>
>> +
>> +# Reduce size of compressed data to 4 sectors: this corrupts the image.
>> +poke_file "$TEST_IMG" $((0x800000)) "\x40\x06"
>> +$QEMU_IO -c "read  -P 0x11 0 4M" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir
>> +
>> +# 'qemu-img check' however doesn't see anything wrong because it
>> +# doesn't try to decompress the data and the refcounts are consistent.
>> +_check_test_img
>
> ...this spot should have a TODO comment that mentions the test needs 
> updating if qemu-img check is taught to be pickier.

Hehe, I actually had a TODO there but decided to remove it in the last
moment.

> Hmm - I also wonder - does our refcount code properly account for a
> compressed cluster that would affect the refcount of THREE clusters?
> Remember, qemu will never emit a compressed cluster that touches more
> than two clusters, but when you enlarge the size, if offset part of
> the link was already in the tail of one cluster, then you can bleed
> over into not just one, but two additional host clusters.  Your test
> didn't cover that, because it uses a compressed cluster that maps to
> the start of the host cluster.

Yes, just fine. I could actually check that by corrupting the second
compressed cluster instead of the first one. Or both, in fact.

I'll send v3 with this change then.

Berto

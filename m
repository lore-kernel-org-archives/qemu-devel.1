Received: from eggs.gnu.org ([2001:4830:134:3::10]:38420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eqKdK-0004xf-Qi
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 10:24:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eqKdG-0002F1-Ot
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 10:24:06 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <220e737d-f773-1420-e632-b94558b98206@redhat.com>
References: <20180226143623.12200-1-berto@igalia.com>
	<220e737d-f773-1420-e632-b94558b98206@redhat.com>
Date: Mon, 26 Feb 2018 16:24:00 +0100
Message-ID: <w51efl7dban.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3] iotests: Test abnormally large size in
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

On Mon 26 Feb 2018 04:12:22 PM CET, Eric Blake wrote:
>> +# Create an empty image, fill half of it with data and compress it.
>> +# The L2 entries of the two compressed clusters are located at
>> +# 0x800000 and 0x800008, their original values are 0x4008000000a00000
>> +# and 0x4008000000a00802 (5 sectors for compressed data each).
>> +TEST_IMG="$TEST_IMG".1 _make_test_img 8M
>> +$QEMU_IO -c "write -P 0x11 0 4M" "$TEST_IMG".1 2>&1 | _filter_qemu_io | _filter_testdir
>> +$QEMU_IMG convert -c -O qcow2 -o cluster_size=2M "$TEST_IMG".1 "$TEST_IMG"
>
> Is it worth a $QEMU_IO -c "read -v 0x800000 16" so that our .out file
> validates that we indeed see the values we expect (if some other qcow2
> change causes us to stick the L2 table at a different offset, the
> verbose read will make it a bit more obvious why this test starts
> failing).

I don't think it's necessary, the success of the rest of the tests after
this one requires that we modify these exact L2 entries. If we're
touching something else then one of them will fail.

Berto

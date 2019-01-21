Received: from eggs.gnu.org ([209.51.188.92]:58665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1glW6q-00032l-4y
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 04:43:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1glW6o-0000Jd-Vz
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 04:43:12 -0500
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:42833)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1glW6n-0000IR-S2
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 04:43:10 -0500
Received: by mail-qk1-x743.google.com with SMTP id 68so11872807qke.9
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 01:43:09 -0800 (PST)
References: <20181107131000.27744-1-danielhb413@gmail.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <e8ec4a68-3dbf-c5c8-e9b5-8f403ac71a5a@gmail.com>
Date: Mon, 21 Jan 2019 07:43:04 -0200
MIME-Version: 1.0
In-Reply-To: <20181107131000.27744-1-danielhb413@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.2 v3 0/3] HMP/snapshot changes - do
 not use ID anymore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, Eric Blake <eblake@redhat.com>

Ping

I believe all the discussion that happened in v2 applies here as well. Do we
have a plan for this series? Should I add something else (warning message
or doc note) to indicate a deprecation of the old meaning of the arguments?


Thanks,


DHB

On 11/7/18 11:09 AM, Daniel Henrique Barboza wrote:
> changes in v3:
> - rebased to v3.1.0-rc0 tag
> - hmp-commands.hx documentation now mentions the change of semantics
> starting version 3.2.
> - previous version link:
> http://lists.nongnu.org/archive/html/qemu-devel/2018-09/msg00629.html
>
>
> It is not uncommon to see bugs being opened by testers that attempt to
> create VM snapshots using HMP. It turns out that "0" and "1" are quite
> common snapshot names and they trigger a lot of bugs. I gave an example
> in the commit message of patch 1, but to sum up here: QEMU treats the
> input of savevm/loadvm/delvm sometimes as 'ID', sometimes as 'name'. It
> is documented as such, but this can lead to strange situations.
>
> Given that it is strange for an API to consider a parameter to be 2 fields
> at the same time, and inadvently treating them as one or the other, and
> that removing the ID field is too drastic, my idea here is to keep the
> ID field for internal control, but do not let the user set it.
>
> This series simplifies the meaning of savevm/loadvm/delvm to be up to
> par to what the QEMU code (and Libvirt) is already doing: snapshot
> operations using "tag" semantics only, leaving the "id" to be
> automatically calculated by the block drivers and used internally
> only.
>
> This change of semantics does not affect existing snapshots. What
> changes is that any HMP operations with them will use the
> updated semantics.
>
>
> Daniel Henrique Barboza (3):
>    block/snapshot.c: eliminate use of ID input in snapshot operations
>    block/snapshot: remove bdrv_snapshot_delete_by_id_or_name
>    qcow2-snapshot: remove redundant find_snapshot_by_id_and_name call
>
>   block/qcow2-snapshot.c   |  5 -----
>   block/snapshot.c         | 25 +++----------------------
>   hmp-commands.hx          | 32 ++++++++++++++++++++------------
>   include/block/snapshot.h |  3 ---
>   qemu-img.c               | 15 +++++++++++----
>   5 files changed, 34 insertions(+), 46 deletions(-)
>

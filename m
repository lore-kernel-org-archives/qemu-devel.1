Received: from eggs.gnu.org ([2001:4830:134:3::10]:38646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fBIrB-0000na-8w
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 07:45:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fBIrA-0002BV-9B
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 07:45:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32974 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fBIrA-0002Ag-4E
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 07:45:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9A423406EA4F
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 11:45:00 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180425112723.1111-1-quintela@redhat.com> (Juan Quintela's
	message of "Wed, 25 Apr 2018 13:27:02 +0200")
References: <20180425112723.1111-1-quintela@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 25 Apr 2018 13:44:51 +0200
Message-ID: <87sh7jy0gc.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v12 00/21] Multifd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Juan Quintela <quintela@redhat.com> wrote:
> Hi
>
>
> [v12]
>
> Big news, it is not RFC anymore, it works reliabely for me.
>
> Changes:
> - Locknig changed completely (several times)
> - We now send  all pages through the channels.  In a 2GB guest with 1 disk and a network card, the amount of data send for RAM was 80KB.
> - This is not optimized yet, but it shouws clear improvements over precopy.  testing over localhost networking I can guet:
>   - 2 VCPUs guest
>   - 2GB RAM
>   - runn stress --vm 4 --vm 500GB (i.e. dirtying 2GB or RAM each second)
>
>   - Total time: precopy ~50seconds, multifd  around 11seconds
>   - Bandwidth usage is around 273MB/s vs 71MB/s on the same hardware
>
> This is very preleminary testing, will send more numbers when I got them.  But looks promissing.
>
> Things that will be improved later:
> - Initial synchronization is too slow (around 1s)
> - We synchronize all threads after each RAM section, we can move to only
>   synchronize them after we have done a bitmap syncrhronization
> - We can improve bitmap walking (but that is independent of multifd)

I forgot to put there that on the last 4 patches, I have not been able
to split them in a way that:
- is logical for review
- works for multifd tests in all versions

So, I ended trynig to get the "logical" viewe, and it works after the
last patch.  Why is that?
- Before I am able to transmit data, I need to be able to
  end/synchronize the different channels
- To finish channels in case of error, I just close the channels
  But I can't opet then yet.

I have to think if I can come with a simpler way to split it, but you
can also consider that the  last 3-4 patches are a single one.

Later, Juan.

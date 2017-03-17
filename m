Received: from eggs.gnu.org ([2001:4830:134:3::10]:46202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1couOC-00058x-2f
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 12:06:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1couO7-0006Gd-27
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 12:06:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1couO6-0006FZ-NS
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 12:05:58 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 70E9A3DBE4
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 16:05:58 +0000 (UTC)
References: <20170313124434.1043-1-quintela@redhat.com>
	<20170313124434.1043-14-quintela@redhat.com>
	<b1d7d458-d3d3-a396-a048-21eea329a05c@redhat.com>
	<20170317130212.GK2396@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4e9d3f9a-7e40-7ad6-90cd-63e7befcfe23@redhat.com>
Date: Fri, 17 Mar 2017 17:05:51 +0100
MIME-Version: 1.0
In-Reply-To: <20170317130212.GK2396@work-vm>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 13/16] migration: Create thread
 infrastructure for multifd recv side
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org



On 17/03/2017 14:02, Dr. David Alan Gilbert wrote:
>>>          case RAM_SAVE_FLAG_MULTIFD_PAGE:
>>>              fd_num =3D qemu_get_be16(f);
>>> -            if (fd_num !=3D 0) {
>>> -                /* this is yet an unused variable, changed later */
>>> -                fd_num =3D fd_num;
>>> -            }
>>> +            multifd_recv_page(host, fd_num);
>>>              qemu_get_buffer(f, host, TARGET_PAGE_SIZE);
>>>              break;
>> I still believe this design is a mistake.
> Is it a use of a separate FD carrying all of the flags/addresses that
> you object to?

Yes, it introduces a serialization point unnecessarily, and I don't
believe the rationale that Juan offered was strong enough.

This is certainly true on the receive side, but serialization is not
even necessary on the send side.  Multiple threads can efficiently split
the work among themselves and visit the dirty bitmap without a central
distributor.

I need to study the code more to understand another issue.  Say you have
a page that is sent to two different threads in two different
iterations, like

    thread 1
      iteration 1: pages 3, 7
    thread 2
      iteration 1: page 3
      iteration 2: page 7

Does the code ensure that all threads wait at the end of an iteration?
Otherwise, thread 2 could process page 7 from iteration 2 before or
while thread 1 processes the same page from iteration 1.

Paolo

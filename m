Received: from eggs.gnu.org ([2001:4830:134:3::10]:45738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fpkZl-0002Wg-P6
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 21:26:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fpkZi-00086A-DE
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 21:26:17 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:53199)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fpkZh-00085U-T7
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 21:26:14 -0400
Date: Tue, 14 Aug 2018 21:26:09 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180815012609.GC17669@flamenco>
References: <20180813171132.21939-1-cota@braap.org>
	<20180813171132.21939-3-cota@braap.org>
	<2f2b1597-6cb1-b6ae-b2a0-38c54e1c34d1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f2b1597-6cb1-b6ae-b2a0-38c54e1c34d1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] monitor: show sync profiling info with
 'info sync'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Weil <sw@weilnetz.de>, Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>

On Tue, Aug 14, 2018 at 10:14:01 +0200, Paolo Bonzini wrote:
> On 13/08/2018 19:11, Emilio G. Cota wrote:
> Would it make sense to add a flag to sort by average wait time

Done:

(qemu) help info sync-profile
info sync-profile [-m] [max] -- show sync profiling info \
for up to max entries (default: 10). By default, entries \
are sorted by total wait time; -m sorts by mean wait time.

(qemu) info sync-profile 3 
Type               Object  Call site       Wait Time (s)         Count  Average (us)
------------------------------------------------------------------------------------
condvar    0x560cc9909e50  cpus.c:1165          63.63428         16081       3957.11
condvar    0x560cc9909e50  cpus.c:1415           0.21074             2     105371.07
BQL mutex  0x560cc85a3fa0  util/rcu.c:269        0.20227            20      10113.60
------------------------------------------------------------------------------------

(qemu) info sync-profile -m 3
Type               Object  Call site       Wait Time (s)         Count  Average (us)
------------------------------------------------------------------------------------
condvar    0x560cc9909e50  cpus.c:1415           0.21074             2     105371.07
BQL mutex  0x560cc85a3fa0  util/rcu.c:269        0.20227            21       9632.00
condvar    0x560cc9909e50  cpus.c:1165          71.92799         18167       3959.27
------------------------------------------------------------------------------------

>, and one to coalesce all mutexes for the same call site?

I am not sure I understand. Do you mean to pass a specific call site,
so that we coalesce all entries related to the call site's object?
Or to keep the call sites separate, but only report entries related
to that specific call site's object?

Thanks,

		Emilio

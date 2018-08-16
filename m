Received: from eggs.gnu.org ([2001:4830:134:3::10]:53261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fqICK-00078Y-PZ
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:20:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fqICC-0006dv-Be
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:20:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33318 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fqICA-0006YV-J0
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:20:12 -0400
Date: Thu, 16 Aug 2018 21:20:02 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180816132002.GF2708@xz-mi>
References: <20180813171132.21939-1-cota@braap.org>
	<20180813171132.21939-3-cota@braap.org>
	<2f2b1597-6cb1-b6ae-b2a0-38c54e1c34d1@redhat.com>
	<20180815012609.GC17669@flamenco>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180815012609.GC17669@flamenco>
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
To: "Emilio G. Cota" <cota@braap.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Weil <sw@weilnetz.de>, Markus Armbruster <armbru@redhat.com>

On Tue, Aug 14, 2018 at 09:26:09PM -0400, Emilio G. Cota wrote:
> On Tue, Aug 14, 2018 at 10:14:01 +0200, Paolo Bonzini wrote:
> > On 13/08/2018 19:11, Emilio G. Cota wrote:
> > Would it make sense to add a flag to sort by average wait time
> 
> Done:
> 
> (qemu) help info sync-profile
> info sync-profile [-m] [max] -- show sync profiling info \
> for up to max entries (default: 10). By default, entries \
> are sorted by total wait time; -m sorts by mean wait time.
> 
> (qemu) info sync-profile 3 
> Type               Object  Call site       Wait Time (s)         Count  Average (us)
> ------------------------------------------------------------------------------------
> condvar    0x560cc9909e50  cpus.c:1165          63.63428         16081       3957.11
> condvar    0x560cc9909e50  cpus.c:1415           0.21074             2     105371.07
> BQL mutex  0x560cc85a3fa0  util/rcu.c:269        0.20227            20      10113.60
> ------------------------------------------------------------------------------------
> 
> (qemu) info sync-profile -m 3
> Type               Object  Call site       Wait Time (s)         Count  Average (us)
> ------------------------------------------------------------------------------------
> condvar    0x560cc9909e50  cpus.c:1415           0.21074             2     105371.07
> BQL mutex  0x560cc85a3fa0  util/rcu.c:269        0.20227            21       9632.00
> condvar    0x560cc9909e50  cpus.c:1165          71.92799         18167       3959.27
> ------------------------------------------------------------------------------------
> 
> >, and one to coalesce all mutexes for the same call site?
> 
> I am not sure I understand. Do you mean to pass a specific call site,
> so that we coalesce all entries related to the call site's object?
> Or to keep the call sites separate, but only report entries related
> to that specific call site's object?

I would guess Paolo means that whether we can merge entries that have
the same call site but with different object addresses.  I copied one
example from the commit message of your patch 1:

Type               Object  Call site          Wait Time (s)         Count  Average (us)
---------------------------------------------------------------------------------------
condvar    0x557ee3090e80  cpus.c:1084              1.69207          2916        580.27
condvar    0x557ee30ceb10  cpus.c:1084              1.43442          2404        596.68
...

IMHO merging of these two entries might be helpful when e.g. the
condvar used there is dynamically created/destroyed, then in this case
the object pointer might not that helpful, instead the statistics of
all the entries for the same call site might tell more.

Regards,

-- 
Peter Xu

Received: from eggs.gnu.org ([2001:4830:134:3::10]:42783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elcE7-0000Wr-AA
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:10:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elcE0-0007y3-Po
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:10:35 -0500
References: <1518437672-7724-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<1518437672-7724-2-git-send-email-mihajlov@linux.vnet.ibm.com>
	<20180212130301.1714d393@redhat.com>
	<5b46d287-cc8a-4d84-cbb4-d6d45e60135b@redhat.com>
	<e635d74e-cf95-20f2-07e4-3ccec08086b0@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <36116a95-d143-8569-f398-7b52af020cfa@redhat.com>
Date: Tue, 13 Feb 2018 09:10:22 -0600
MIME-Version: 1.0
In-Reply-To: <e635d74e-cf95-20f2-07e4-3ccec08086b0@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 1/3] qmp: expose s390-specific
 CPU info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Luiz Capitulino <lcapitulino@redhat.com>
Cc: agraf@suse.de, berrange@redhat.com, ehabkost@redhat.com, crosthwaite.peter@gmail.com, armbru@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, pbonzini@redhat.com, rth@twiddle.net

On 02/13/2018 06:20 AM, Viktor Mihajlovski wrote:
>>> We're adding the same information to query-cpus-fast. Why do we
>>> need to duplicate this into query-cpus? Do you plan to keep using
>>> query-cpus? If yes, why?
>>
>> Wonder if we could simply pass a flag to query-cpus "fast=true", that
>> makes it behave differently. (either not indicate the critical values or
>> simply provide dummy values - e.g. simply halted=false)
>>
> That was one of the ideas in the earlier stages of this discussion (and
> I was inclined to go that way initially). The major drawback of this
> approach that the slow call is hard to deprecate (OK, one could change
> the default to fast=true over time). It's easier to deprecate the entire
> query-cpus function. The other issue, maybe not as bad, is that one has
> to deal with fields that are suddenly optional or obsolete in way not
> confusing every one.
> Bottom line is that I'm convinced it's better to have both APIs and to
> deprecate the slow one over time. But I have to confess I'm not familiar
> with QAPI deprecation rules, maybe Eric can shed some light on this...

You are correct that it is easier to have two commands if we plan for 
one to completely disappear (after a proper deprecation period, where it 
is well-documented for a couple of releases that we plan on removing the 
older command).  The alternative of adding a bool that controls whether 
the painful fields are omitted, is partially introspecitble (you can 
learn whether the new bool exists, in which case you use it for the new 
behavior), but later changing the default value of that bool over time 
is not (as we don't yet have a way to introspect default values - maybe 
we should add that someday, but we're not there yet).  But right now, it 
is easy to introspect the addition of a new command (if it exists, use 
it) and a later disappearance of a command.  So I'm in agreement with 
your approach of a new command.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

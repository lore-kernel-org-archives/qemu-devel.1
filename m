Received: from eggs.gnu.org ([209.51.188.92]:35203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gzl5P-00089w-P8
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:32:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gzl5O-0006GH-VZ
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:32:35 -0500
References: <20190227172256.30368-1-kwolf@redhat.com>
	<20190227172256.30368-4-kwolf@redhat.com>
	<20190301161724.GB18260@stefanha-x1.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d6ba8e66-5ddf-9091-ff44-5024a53240a8@redhat.com>
Date: Fri, 1 Mar 2019 10:32:27 -0600
MIME-Version: 1.0
In-Reply-To: <20190301161724.GB18260@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 03/20] qcow2: Extend spec for
 external data files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

On 3/1/19 10:17 AM, Stefan Hajnoczi wrote:
> On Wed, Feb 27, 2019 at 06:22:39PM +0100, Kevin Wolf wrote:
>> -                    Bits 2-63:  Reserved (set to 0)
>> +                    Bit 2:      External data file bit.  If this bit is set, an
>> +                                external data file is used. Guest clusters are
>> +                                then stored in the external data file. For such
>> +                                images, clusters in the external data file are
>> +                                not refcounted. The offset field in the
>> +                                Standard Cluster Descriptor must match the
>> +                                guest offset and neither compressed clusters
>> +                                nor internal snapshots are supported.
>> +
>> +                                An external data file name header extension may
>> +                                be present if this bit is set.
> 
> This sentence is clearer if the header extension name is made prominent:
> 
>   An "external data file name" header extension
> 
> Or
> 
>   An External Data File Name header extension
> 
> (In the previous paragraph Standard Cluster Descriptor is also
> capitalized.)

Indeed, so I like the latter suggestion.

> 
>> @@ -148,6 +170,7 @@ be stored. Each extension has a structure like the following:
>>                          0x6803f857 - Feature name table
>>                          0x23852875 - Bitmaps extension
>>                          0x0537be77 - Full disk encryption header pointer
>> +                        0x44415441 - External data file name
> 
> This new header extension isn't described in this patch?

I asked the same on v1, and the answer (which remains valid) is that
neither is 0xe2792aca Backing file format name.  (In other words, both
extensions are simple enough as a single file name to be implicitly
described by the reference to the header in the earlier text).  Making
both explicit wouldn't hurt my feelings, but I don't see it as a
showstopper to the patch as-is.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

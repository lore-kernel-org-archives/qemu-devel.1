Received: from eggs.gnu.org ([2001:4830:134:3::10]:39497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlipchuk@redhat.com>) id 1cgZa5-0000eh-HQ
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 11:15:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlipchuk@redhat.com>) id 1cgZa2-0007aJ-4D
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 11:15:53 -0500
Received: from mail-it0-f45.google.com ([209.85.214.45]:38045)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlipchuk@redhat.com>) id 1cgZa1-0007ZL-Pl
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 11:15:50 -0500
Received: by mail-it0-f45.google.com with SMTP id y135so4376758itc.1
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 08:15:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAMRbyyssi_rspwDJTtWM1Ju5CTZ15z1xBikRDONrS84rx+B8Qg@mail.gmail.com>
References: <CAJ1JNOd5cZ3RWUAkY=uo7+wwSwQrBWrN6GF_QZFjdVfx49VtGQ@mail.gmail.com>
	<20170215151419.GD16064@stefanha-x1.localdomain>
	<CAMRbyysZUv1YQa+veW--K9FDDLkXnY5TCSmTS4xPb1sB6kODcw@mail.gmail.com>
	<20170220110732.GE21255@stefanha-x1.localdomain>
	<CAJ1JNOdzD7DHTHGJEO2YQANDPq0kY-PEh6J1jBkP7hUW0Kvy9w@mail.gmail.com>
	<CAMRbyyssi_rspwDJTtWM1Ju5CTZ15z1xBikRDONrS84rx+B8Qg@mail.gmail.com>
From: Maor Lipchuk <mlipchuk@redhat.com>
Date: Wed, 22 Feb 2017 18:15:47 +0200
Message-ID: <CAJ1JNOcOKvSBswMQt+2y_jkjHRUeVo33CfJRKhsPfeqfOqMnuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Estimation of qcow2 image size converted from raw
 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-discuss@nongnu.org, qemu-devel@nongnu.org
Cc: Allon Mureinik <amureini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>, John Snow Huston <jhuston@redhat.com>

Hi all,

Thank you very much for your help, it was much helpful
We adopted John Snow advice and implemented our own calculation so we
can resolve the issue now,
We plan to drop this code once we can get this estimation from qemu-img.

This is the link to the patch introducing the calculation:
https://gerrit.ovirt.org/#/c/65039/14/lib/vdsm/storage/qcow2.py

And here are link to the tests that we added:
https://gerrit.ovirt.org/#/c/65039/14/tests/storage_qcow2_test.py

Here is how the calculation goes:

We first use qemuimg map to get the used clusters and count all the
clusters for each run returned from qemuimg.map(filename):

 def count_clusters(runs):
    count = 0
     last = -1
     for r in runs:
         # Find the cluster when start and end are located.
         start = r["start"] // CLUSTER_SIZE
         end = (r["start"] + r["length"]) // CLUSTER_SIZE
         if r["data"]:
             if start == end:
                 # This run is smaller then a cluster. If we have several runs
                 # in the same cluster, we want to count the cluster only once.
                 if start != last:
                     count += 1
             else:
                 # This run span over multiple clusters - we want to count all
                 # the clusters this run touch.
                 count += end - start
             last = end
     return count


The following calculation is based on Kevin's comments on the original
bug, and qcow2 spec:
https://github.com/qemu/qemu/blob/master/docs/specs/qcow2.txt:

     header_size = 3 * CLUSTER_SIZE

     virtual_size = os.stat(filename).st_size

     # Each 512MiB has one l2 table (64K)
     l2_tables = (virtual_size + (512 * 1024**2) - 1) // (512 * 1024**2)
     l2_tables_size = l2_tables * CLUSTER_SIZE

     # Each cluster have a refcount entry (16 bits) in the refcount tables. It
     # is not clear what is the size of the refcount table, lets assume it is
     # the same size as the l2 tables.
     refcounts_tables_size = l2_tables_size


After we calculate the estimated size we do the following logic and
multiply it with 1.1:

     chunk_size = config.getint("irs",
                                "volume_utilization_chunk_mb")
     chunk_size = chunk_size * sc.MEGAB
     newsize = (estimate_size + chunk_size) / sc.BLOCK_SIZE
     self.log.debug("Estimated allocation for qcow2 volume:"
                    "%d bytes", newsize)
     newsize = newsize * 1.1


Please let me know if that calculation is acceptable and makes since
for this use case

Thanks,
Maor



>> On Mon, Feb 20, 2017 at 1:07 PM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>>> On Wed, Feb 15, 2017 at 05:49:58PM +0200, Nir Soffer wrote:
>>>> On Wed, Feb 15, 2017 at 5:14 PM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>>>> > On Mon, Feb 13, 2017 at 05:46:19PM +0200, Maor Lipchuk wrote:
>>>> >> I was wondering if that is possible to provide a new API that
>>>> >> estimates the size of
>>>> >> qcow2 image converted from a raw image. We could use this new API to
>>>> >> allocate the
>>>> >> size more precisely before the convert operation.
>>>> >>
>>>> > [...]
>>>> >> We think that the best way to solve this issue is to return this info
>>>> >> from qemu-img, maybe as a flag to qemu-img convert that will
>>>> >> calculate the size of the converted image without doing any writes.
>>>> >
>>>> > Sounds reasonable.  qcow2 actually already does some of this calculation
>>>> > internally for image preallocation in qcow2_create2().
>>>> >
>>>> > Let's try this syntax:
>>>> >
>>>> >   $ qemu-img query-max-size -f raw -O qcow2 input.raw
>>>> >   1234678000
>>>>
>>>> This is little bit verbose compared to other commands
>>>> (e.g. info, check, convert)
>>>>
>>>> Since this is needed only during convert, maybe this can be
>>>> a convert flag?
>>>>
>>>>     qemu-img convert -f xxx -O yyy src dst --estimate-size --output json
>>>>     {
>>>>         "estimated size": 1234678000
>>>>     }
>>>
>>> What is dst?  It's a dummy argument.
>>>
>>> Let's not try to shoehorn this new sub-command into qemu-img convert.
>>>
>>>> > As John explained, it is only an estimate.  But it will be a
>>>> > conservative maximum.
>>>> >
>>>> > Internally BlockDriver needs a new interface:
>>>> >
>>>> > struct BlockDriver {
>>>> >     /*
>>>> >      * Return a conservative estimate of the maximum host file size
>>>> >      * required by a new image given an existing BlockDriverState (not
>>>> >      * necessarily opened with this BlockDriver).
>>>> >      */
>>>> >     uint64_t (*bdrv_query_max_size)(BlockDriverState *other_bs,
>>>> >                                     Error **errp);
>>>> > };
>>>> >
>>>> > This interface allows individual block drivers to probe other_bs in
>>>> > whatever way necessary (e.g. querying block allocation status).
>>>> >
>>>> > Since this is a conservative max estimate there's no need to read all
>>>> > data to check for zero regions.  We should give the best estimate that
>>>> > can be generated quickly.
>>>>
>>>> I think we need to check allocation (e.g. with SEEK_DATA), I hope this
>>>> is what you mean by not read all data.
>>>
>>> Yes, allocation data must be checked.  But it will not read data
>>> clusters from disk to check if they contains only zeroes.
>>>
>>> Stefan

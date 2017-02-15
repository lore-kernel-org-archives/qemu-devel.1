Received: from eggs.gnu.org ([2001:4830:134:3::10]:56961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1ce1qG-0006lF-EC
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 10:50:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1ce1qC-0007a2-Ia
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 10:50:04 -0500
Received: from mail-ua0-f178.google.com ([209.85.217.178]:36258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1ce1qC-0007ZH-ER
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 10:50:00 -0500
Received: by mail-ua0-f178.google.com with SMTP id 96so108310958uaq.3
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 07:49:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170215151419.GD16064@stefanha-x1.localdomain>
References: <CAJ1JNOd5cZ3RWUAkY=uo7+wwSwQrBWrN6GF_QZFjdVfx49VtGQ@mail.gmail.com>
	<20170215151419.GD16064@stefanha-x1.localdomain>
From: Nir Soffer <nsoffer@redhat.com>
Date: Wed, 15 Feb 2017 17:49:58 +0200
Message-ID: <CAMRbyysZUv1YQa+veW--K9FDDLkXnY5TCSmTS4xPb1sB6kODcw@mail.gmail.com>
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
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Maor Lipchuk <mlipchuk@redhat.com>, qemu-devel@nongnu.org, qemu-discuss@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Allon Mureinik <amureini@redhat.com>, Max Reitz <mreitz@redhat.com>

On Wed, Feb 15, 2017 at 5:14 PM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Mon, Feb 13, 2017 at 05:46:19PM +0200, Maor Lipchuk wrote:
>> I was wondering if that is possible to provide a new API that
>> estimates the size of
>> qcow2 image converted from a raw image. We could use this new API to
>> allocate the
>> size more precisely before the convert operation.
>>
> [...]
>> We think that the best way to solve this issue is to return this info
>> from qemu-img, maybe as a flag to qemu-img convert that will
>> calculate the size of the converted image without doing any writes.
>
> Sounds reasonable.  qcow2 actually already does some of this calculation
> internally for image preallocation in qcow2_create2().
>
> Let's try this syntax:
>
>   $ qemu-img query-max-size -f raw -O qcow2 input.raw
>   1234678000

This is little bit verbose compared to other commands
(e.g. info, check, convert)

Since this is needed only during convert, maybe this can be
a convert flag?

    qemu-img convert -f xxx -O yyy src dst --estimate-size --output json
    {
        "estimated size": 1234678000
    }

> As John explained, it is only an estimate.  But it will be a
> conservative maximum.
>
> Internally BlockDriver needs a new interface:
>
> struct BlockDriver {
>     /*
>      * Return a conservative estimate of the maximum host file size
>      * required by a new image given an existing BlockDriverState (not
>      * necessarily opened with this BlockDriver).
>      */
>     uint64_t (*bdrv_query_max_size)(BlockDriverState *other_bs,
>                                     Error **errp);
> };
>
> This interface allows individual block drivers to probe other_bs in
> whatever way necessary (e.g. querying block allocation status).
>
> Since this is a conservative max estimate there's no need to read all
> data to check for zero regions.  We should give the best estimate that
> can be generated quickly.

I think we need to check allocation (e.g. with SEEK_DATA), I hope this
is what you mean by not read all data.

Nir

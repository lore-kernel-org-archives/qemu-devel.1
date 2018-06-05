Received: from eggs.gnu.org ([2001:4830:134:3::10]:35453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fQIr0-0006K6-LY
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 16:46:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fQIqz-0007UH-AI
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 16:46:54 -0400
References: <20180528212054.GH2209@redhat.com>
	<20180528212510.GC4660@redhat.com>
	<20180529064415.GA4756@localhost.localdomain>
	<2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
	<20180605092159.GA2544@work-vm>
	<20180605190324.GA11372@localhost.localdomain>
	<20180605223934-mutt-send-email-mst@kernel.org>
	<a9fdbe0f-2c39-7da3-11f2-6752b74cce08@redhat.com>
	<20180605195855.GC1455@redhat.com>
	<6f6ecbb5-3175-44d0-5922-b13ac163f006@redhat.com>
	<20180605231419-mutt-send-email-mst@kernel.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0dce5af0-8fd8-b22f-3642-49a55ba37804@redhat.com>
Date: Tue, 5 Jun 2018 15:46:45 -0500
MIME-Version: 1.0
In-Reply-To: <20180605231419-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Richard W.M. Jones" <rjones@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com, Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 06/05/2018 03:28 PM, Michael S. Tsirkin wrote:
> On Tue, Jun 05, 2018 at 03:09:17PM -0500, Eric Blake wrote:
>> On 06/05/2018 02:58 PM, Richard W.M. Jones wrote:
>>>> Binary blobs can always be base64 encoded for representation within
>>>> a valid JSON UTF-8 string (and we already have several QMP
>>>> interfaces that utilize base64 encoding to pass through what is
>>>> otherwise invalid UTF-8).  It does inflate things slightly compared
>>>> to a format that allows a raw length coupled with raw data, but that
>>>> is not necessarily a problem.
>>>
>>> Of course how we represent them externally and/or while
>>> using QMP / qemu-img to store and retrieve them is up for grabs.
>>> Doesn't JSON allow binary to be encoded?  (Knowing how poorly
>>> done JSON is, I wouldn't be surprised if not)
>>
>> JSON itself does not have a binary primitive; to pass arbitrary data through
>> JSON you have to first encode that data into something like base64 that can
>> then be represented as a UTF-8 string.  For reference, look at
>> qapi/crypto.json and the definition of QCryptoSecretFormat.
> 
> But there isn't a way to figure out that a string is base64, which
> means each application needs to know whether it's a string or
> a binary.

Other than if the key name is well-known (and interpretation of the 
value is done according to the key, if it is interpreted at all).

> 
> How about specifying the encoding in the value?
> 
> string value:
> [A-Za-z][^=\0]=S[^\0]*
> 
> base64 value:
> [A-Za-z][^=\0]=B[A-Za-z0-9+/]*
> 
> or the key:
> S[A-Za-z][^=\0]=[^\0]*
> 
> base64 value:
> B[A-Za-z][^=\0]=[A-Za-z0-9+/]*

If we're going to express a tuple of <key,type,value>, then let's 
describe it as a 3-tuple, rather than trying to overload that into a 
2-tuple key=value syntax.  After all, while you may want a high-level 
layer 1 representation in JSON or something else easy to hand off to 
other processing, there's no requirement that the layer 0 storage in 
qcow2 can't be a struct in some other layout, even if we have to convert 
between layouts for what is stored in the file vs. what is presented to 
the user.

By that argument, a single JSON object (if we insist on storing a single 
JSON object as layer 0) might be:

[ { "name": "foo", "type": "raw", "value": "bar" },
   { "name": "quux", "type": "base64", "value": "aGVsbG8=" } ]

But figuring out how to add a "Header extension type" to 
docs/interop/qcow2.txt, and whether the key/value payload will usefully 
fit in that header extension (where we are tight on spacing, as ALL 
extensions combined must fit in a single cluster), or whether the header 
should instead have an offset field that points to some other cluster in 
the qcow2 image, is relatively straightforward, and relatively 
independent of the even bigger design question of whether we want to 
allow qcow2 as an image format to expose an arbitrary data store feature 
and what types of data should go into that store.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

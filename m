Received: from eggs.gnu.org ([2001:4830:134:3::10]:37554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1clDy8-0003vF-2f
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 07:11:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1clDy3-0005tp-2D
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 07:11:56 -0500
Received: from smtp3.mundo-r.com ([212.51.32.191]:10097 helo=smtp4.mundo-r.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1clDy2-0005sF-82
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 07:11:50 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170307103654.GD15368@redhat.com>
References: <20170303135150.12145-1-stefanha@redhat.com>
	<20170307103654.GD15368@redhat.com>
Date: Tue, 07 Mar 2017 13:11:44 +0100
Message-ID: <w51fuip2sn3.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC 0/4] qemu-img: add max-size subcommand
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, Nir Soffer <nsoffer@redhat.com>, John Snow <jsnow@redhat.com>

On Tue 07 Mar 2017 11:36:54 AM CET, Daniel P. Berrange wrote:
>> The creation scenario is:
>> 
>>   $ qemu-img max-size -O qcow2 --size 5G
>>   196688
>
> Hmm, so that appears to be indicating the amount of physical space
> that a qcow2 image would take up before any data has been written to
> it.
>
> That's not actually what I was thinking. I would like to know the
> maximum possible physical space that a 5G qcow2 image would take up
> once data is written to every sector. Obviously this is impossible to
> say if you allow for internal snapshots, but I think it is fine to say
> that we ignore internal snapshots for purposes of this command.

We have clearly two different use cases here, although I wonder how
useful the one that you are describing is. After all the maximum size of
a fully allocated imaged is always going to be the virtual size plus a
small overhead for the metadata. I haven't made the numbers for all
cases, but I'll take the risk and say it's always going to be really
small (the 10% you use to illustrate your point is way too much).

A fully allocated 1TB qcow2 image needs less than 200MB of metadata
(that's 0.02% of the total size). If we reduce the cluster size to its
minimum (512 bytes) then it's around 20GB (still ~2% of the total size).

Computing the size that you need to convert the data that is currently
allocated is a different matter, because it depends a lot on the
scenario: whether you are using preallocation, or you have backing
images, etc.

Berto

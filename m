Received: from eggs.gnu.org ([2001:4830:134:3::10]:33416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpAZO-00034C-GK
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:55:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpAZJ-0001mo-Up
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:54:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dpAZJ-0001lv-P3
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:54:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ADB17356C7
	for <qemu-devel@nongnu.org>; Tue,  5 Sep 2017 09:54:52 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-9-eblake@redhat.com>
	<0a344384-f482-5602-490a-928db53c46b5@redhat.com>
Date: Tue, 05 Sep 2017 11:54:51 +0200
In-Reply-To: <0a344384-f482-5602-490a-928db53c46b5@redhat.com> (Thomas Huth's
	message of "Tue, 5 Sep 2017 10:12:30 +0200")
Message-ID: <87zia9xyfo.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 08/29] libqtest: Let socket_send()
 compute length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, pbonzini@redhat.com

Thomas Huth <thuth@redhat.com> writes:

> On 01.09.2017 20:03, Eric Blake wrote:
>> Rather than make multiple callers call strlen(), it's easier if
>> socket_send() itself can compute a length via strlen() if none
>> was provided (caller passes -1).  Callers that can get at the
>> length more efficiently are left that way.
>> 
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>  tests/libqtest.c | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> I have to say that I don't like this idea very much. socket_send()
> should IMHO not know about the type of the data that should be sent,
> i.e. it should not assume that the content is a zero-terminated string.

I agree.

> This also could lead to some hard to detect bugs later in case somebody
> is calling the function like this:
>
>   size = someotherfunction();
>   socket_send(fd, buf, size);
>
> ... and the someotherfunction() returned a negative error code instead
> of a correct size.
>
> So I'd like to suggest to simply drop this patch.

A separate wrapper function for sending zero-terminated strings would be
fine with me.

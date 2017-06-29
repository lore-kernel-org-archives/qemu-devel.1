Received: from eggs.gnu.org ([2001:4830:134:3::10]:49870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dQTtK-0008TQ-K4
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 03:29:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dQTtG-0004gr-Mk
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 03:29:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dQTtG-0004fh-Eo
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 03:29:26 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1498654240.git.maozy.fnst@cn.fujitsu.com>
	<d7c1b8ff9247a09e54110abe6abe93543d59b8b6.1498654240.git.maozy.fnst@cn.fujitsu.com>
	<20170628132329.GJ29134@redhat.com>
	<c25da728-d3cf-2b24-19e8-0a67e69fd65c@redhat.com>
	<20170628142851.GO29134@redhat.com>
Date: Thu, 29 Jun 2017 09:29:20 +0200
In-Reply-To: <20170628142851.GO29134@redhat.com> (Daniel P. Berrange's message
	of "Wed, 28 Jun 2017 15:28:51 +0100")
Message-ID: <87d19n2qwf.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 3/4] net/net: Convert parse_host_port()
 to Error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, jasowang@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com, pbonzini@redhat.com

"Daniel P. Berrange" <berrange@redhat.com> writes:

> On Wed, Jun 28, 2017 at 09:24:58AM -0500, Eric Blake wrote:
>> On 06/28/2017 08:23 AM, Daniel P. Berrange wrote:
>> > On Wed, Jun 28, 2017 at 09:08:49PM +0800, Mao Zhongyi wrote:
>> >> diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
>> >> index 5c326db..78e2b30 100644
>> >> --- a/include/qemu/sockets.h
>> >> +++ b/include/qemu/sockets.h
>> > 
>> >>          if (qemu_isdigit(buf[0])) {
>> >> -            if (!inet_aton(buf, &saddr->sin_addr))
>> >> +            if (!inet_aton(buf, &saddr->sin_addr)) {
>> >> +                error_setg(errp, "host address '%s' is not a valid "
>> >> +                           "IPv4 address", buf);
>> >>                  return -1;
>> >> +            }
>> >>          } else {
>> >> -            if ((he = gethostbyname(buf)) == NULL)
>> >> +            he = gethostbyname(buf);
>> >> +            if (he == NULL) {
>> >> +                error_setg(errp, "can't resolve host address '%s': "
>> >> +                           "unknown host", buf);
>> >>                  return - 1;
>> >> +            }
>> > 
>> > gethostbyname sets  'h_errno' on failure, so you should pass that
>> > into error_setg_errno, instead of hardcoding 'unknown host' as a
>> > message

'unknown host' is misleading when h_errno != HOST_NOT_FOUND.

>> 'man gethostbyname' says it is deprecated, and that applications should
>> use getaddrinfo/getnameinfo instead.  What's our story here?
>
> The real story is to get net/socket.c converted to QIOChannelSocket
> and kill this parse_host_port() method in sockets.c It is already
> broken by design since it takes a 'struct sockdddr_in' and thus
> can't do IPv6.
>
> This patch doesn't make the existing situation worse, so I think
> its fine to add this error reporting cleanup now, and not force
> immediate conversion to QIOChannelSocket today.  The net/sockets.c
> code needs a further refactor before that conversion can be done
> in the right way - we've already reverted the wrong way twice ;-)

Until then, let's go with a generic error message, as I requested in my
review of v5.  Just drop the misleading ": unknown host" part.

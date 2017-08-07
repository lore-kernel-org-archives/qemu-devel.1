Received: from eggs.gnu.org ([2001:4830:134:3::10]:57818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1delF5-0000La-7O
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 12:51:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1delF0-0006Xl-8r
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 12:50:59 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1502117160-24655-19-git-send-email-armbru@redhat.com> (Markus
	Armbruster's message of "Mon, 7 Aug 2017 16:45:22 +0200")
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
	<1502117160-24655-19-git-send-email-armbru@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 07 Aug 2017 18:50:36 +0200
Message-ID: <878tive2zn.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC PATCH 18/56] migration: Make parameter
 max-bandwidth unsigned in QAPI/QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, dgilbert@redhat.com, berrange@redhat.com, qemu-block@nongnu.org

Markus Armbruster <armbru@redhat.com> wrote:
> Byte rates should use QAPI type 'size' (uint64_t).
> migrate_set_speed's parameter @value and member @max-bandwidth of
> MigrationParameters and MigrateSetParameters are 'int' (int64_t).
>
> Change them all to 'size'.
>
> migrate_set_speed and migrate-set-parameters now accept bandwidth
> values between 2^63 and SIZE_MAX (commonly 2^64-1).  They accept
> negative values as before, because that's how the QObject input
> visitor works for backward compatibility.
>
> So does HMP's migrate_set_speed, except it continues to reject
> negative values.
>
> query-migrate-parameters now reports bandwidth values above 2^63-1
> correctly instead of their (negative) two's complement.
>
> So does HMP's "info migrate_params".
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

> -    if (params->has_max_bandwidth &&
> -        (params->max_bandwidth < 0 || params->max_bandwidth > SIZE_MAX)) {
> +    if (params->has_max_bandwidth && params->max_bandwidth > SIZE_MAX) {


Much nicer for something that we know can't be negative O:-)
